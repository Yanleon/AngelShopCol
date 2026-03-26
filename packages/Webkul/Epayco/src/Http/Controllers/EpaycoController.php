<?php

namespace Webkul\Epayco\Http\Controllers;

use App\Http\Controllers\Controller;
use Webkul\Sales\Repositories\OrderRepository;
use Webkul\Sales\Transformers\OrderResource;
use Webkul\Epayco\Services\EpaycoService;
use Webkul\Checkout\Facades\Cart;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class EpaycoController extends Controller
{
    public function __construct(
        protected OrderRepository $orderRepository,
        protected EpaycoService $epaycoService
    ) {}

    public function setOrder()
    {
        return response()->json($this->epaycoService->buildPayload());
    }

    public function success(Request $request)
    {
        $ref_payco = $request->query('ref_payco');

        if (!$ref_payco) {
            return redirect()->route('shop.checkout.cart.index')
                ->with('error', 'Error en el pago');
        }

        try {
            $charge = $this->epaycoService->verifyCharge($ref_payco);

            if (!$charge || !isset($charge['data'])) {
                return redirect()->route('shop.checkout.cart.index')
                    ->with('error', 'Error verificando pago');
            }

            $data = $charge['data'];
            $codResponse = (string) ($data['x_cod_response'] ?? '0');

            if (in_array($codResponse, ['2', '4'])) {
                return redirect()->route('shop.checkout.cart.index')
                    ->with('error', 'Pago no aprobado');
            }

            $cart = Cart::getCart();

            if (!$cart || !$cart->items->count()) {
                return redirect()->route('shop.checkout.cart.index')
                    ->with('error', 'Carrito vacÃo');
            }

            $order = $this->orderRepository->create(
                (new OrderResource($cart))->jsonSerialize()
            );

            $status = $codResponse === '1' ? 'completed' : 'pending';

            $this->orderRepository->update([
                'status' => $status,
                'transaction_id' => $data['x_ref_payco'] ?? $ref_payco
            ], $order->id);

            Cart::deActivateCart();

            session()->flash('order_id', $order->id);

            return redirect()->route('shop.checkout.onepage.success');

        } catch (\Throwable $e) {
            Log::error('ERROR SUCCESS EPAYCO: ' . $e->getMessage());

            return redirect()->route('shop.checkout.cart.index')
                ->with('error', 'Error interno');
        }
    }
}