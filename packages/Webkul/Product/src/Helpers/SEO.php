<?php

namespace Webkul\Product\Helpers;

use Illuminate\Support\Facades\Storage;

class SEO
{
    /**
     * Returns product json ld data for product
     *
     * @param  \Webkul\Product\Contracts\Product  $product
     * @return string
     */
    public function getProductJsonLd($product)
    {
        $data = [
            '@context'    => 'https://schema.org/',
            '@type'       => 'Product',
            'name'        => $product->name,
            'description' => strip_tags($product->description),
            'url'         => route('shop.product_or_category.index', $product->url_key),
        ];

        if (core()->getConfigData('catalog.rich_snippets.products.show_sku')) {
            $data['sku'] = $product->sku;
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_weight')) {
            $data['weight'] = $product->weight;
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_categories')) {
            $data['category'] = $this->getProductCategories($product);
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_images')) {
            $images = $this->getProductImages($product);

            if (! empty($images)) {
                $data['image'] = $images;
            }
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_reviews')) {
            $reviews = $this->getProductReviews($product);

            if (! empty($reviews)) {
                $data['review'] = $reviews;
            }
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_ratings')) {
            $aggregateRating = $this->getProductAggregateRating($product);

            // ✅ SOLO SE AGREGA SI HAY RESEÑAS
            if (! is_null($aggregateRating)) {
                $data['aggregateRating'] = $aggregateRating;
            }
        }

        if (core()->getConfigData('catalog.rich_snippets.products.show_offers')) {
            $data['offers'] = $this->getProductOffers($product);
        }

        return json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    }

    /**
     * Returns product categories
     */
    public function getProductCategories($product)
    {
        return implode(', ', $product->categories->pluck('name')->toArray());
    }

    /**
     * Returns product images
     */
    public function getProductImages($product)
    {
        $images = [];

        foreach ($product->images as $image) {
            if (Storage::has($image->path)) {
                $images[] = $image->url;
            }
        }

        return $images;
    }

    /**
     * Returns product reviews (ONLY approved)
     */
    public function getProductReviews($product)
    {
        $reviews = [];

        foreach ($product->reviews()->where('status', 'approved')->get() as $review) {
            $reviews[] = [
                '@type'        => 'Review',
                'reviewRating' => [
                    '@type'       => 'Rating',
                    'ratingValue' => (int) $review->rating,
                    'bestRating'  => '5',
                ],
                'author'       => [
                    '@type' => 'Person',
                    'name'  => $review->name,
                ],
            ];
        }

        return $reviews;
    }

    /**
     * Returns product aggregate rating
     * ✅ SOLO SI HAY RESEÑAS (EVITA ERROR DE GOOGLE)
     */
    public function getProductAggregateRating($product)
    {
        $reviewHelper = app('Webkul\Product\Helpers\Review');
        $totalReviews = $reviewHelper->getTotalReviews($product);

        if ($totalReviews <= 0) {
            return null;
        }

        return [
            '@type'       => 'AggregateRating',
            'ratingValue' => number_format($reviewHelper->getAverageRating($product), 1),
            'reviewCount' => $totalReviews,
        ];
    }

    /**
     * Returns product offers
     */
    public function getProductOffers($product)
    {
        return [
            '@type'         => 'Offer',
            'priceCurrency' => core()->getCurrentCurrencyCode(),
            'price'         => number_format($product->getTypeInstance()->getMinimalPrice(), 0, '', ''),
            'availability'  => 'https://schema.org/InStock',
            'url'           => route('shop.product_or_category.index', $product->url_key),
        ];
    }

    /**
     * Returns category json ld data
     */
    public function getCategoryJsonLd($category)
    {
        $data = [
            '@context' => 'https://schema.org',
            '@type'    => 'WebSite',
            'url'      => config('app.url'),
        ];

        if (core()->getConfigData('catalog.rich_snippets.categories.show_search_input_field')) {
            $data['potentialAction'] = [
                '@type'       => 'SearchAction',
                'target'      => config('app.url') . '/search/?term={search_term_string}',
                'query-input' => 'required name=search_term_string',
            ];
        }

        return json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    }
}
