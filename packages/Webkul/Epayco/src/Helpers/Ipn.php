<?php

namespace Webkul\Epayco\Helpers;

use Illuminate\Support\Facades\Log;
use Webkul\Sales\Repositories\InvoiceRepository;
use Webkul\Sales\Repositories\OrderRepository;

class Ipn
{
    protected $post;
    protected $order;
    protected $public_key;
    protected $cust_id_client;
    protected $p_key;

    public function __construct(
        protected OrderRepository $orderRepository,
        protected InvoiceRepository $invoiceRepository,
    ) {}

    public function processIpn($post)
    {
        $this->post = $post;

        try {
            Log::info('Epayco IPN received', $post);

            $this->public_key = core()->getConfigData('sales.payment_methods.epayco.public_key');
            $this->cust_id_client = core()->getConfigData('sales.payment_methods.epayco.cust_id_client');
            $this->p_key = core()->getConfigData('sales.payment_methods.epayco.p_key');

            $this->getOrder();

            if (!$this->order) {
                Log::error('Order not found', $post);
                return response()->json(['error' => 'Order not found'], 404);
            }

            return $this->processOrder();

        } catch (\Exception $e) {
            Log::error('Epayco IPN error: ' . $e->getMessage());
            return response()->json(['error' => 'IPN error'], 500);
        }
    }

    protected function getOrder()
    {
        $this->order = $this->orderRepository->find($this->post['x_id_invoice'] ?? null);
        return $this->order;
    }

    protected function processOrder()
    {
        $x_ref_payco = $this->post['x_ref_payco'];
        $x_transaction_id = $this->post['x_transaction_id'];
        $x_amount = (int) $this->post['x_amount'];
        $x_currency_code = $this->post['x_currency_code'];
        $x_signature = $this->post['x_signature'];
        $x_cod_response = (int) $this->post['x_cod_response'];

        $signature = hash('sha256',
            $this->cust_id_client . '^' .
            $this->p_key . '^' .
            $x_ref_payco . '^' .
            $x_transaction_id . '^' .
            $x_amount . '^' .
            $x_currency_code
        );

        if ($x_signature !== $signature) {
            Log::error('Invalid signature');
            return response()->json(['error' => 'Invalid signature'], 400);
        }

        if ((int)$this->order->grand_total !== $x_amount) {
            Log::error('Amount mismatch');
            return response()->json(['error' => 'Amount mismatch'], 400);
        }

        if ($this->order->status === 'completed') {
            return response()->json(['message' => 'Already processed']);
        }

        if ($x_cod_response === 1) {
            $status = 'completed';
        } elseif ($x_cod_response === 3) {
            $status = 'pending';
        } else {
            $status = 'canceled';
        }

        $this->orderRepository->update([
            'status' => $status,
            'transaction_id' => $x_ref_payco
        ], $this->order->id);

        if ($status === 'completed' && $this->order->canInvoice()) {
            $this->invoiceRepository->create($this->prepareInvoiceData());
        }

        return response()->json(['status' => $status]);
    }

    protected function prepareInvoiceData()
    {
        $invoiceData = ['order_id' => $this->order->id];

        foreach ($this->order->items as $item) {
            $invoiceData['invoice']['items'][$item->id] = $item->qty_to_invoice;
        }

        return $invoiceData;
    }
}