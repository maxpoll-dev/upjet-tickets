<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderCreatedResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'order_id' => $this->id,
            'access_token' => $this->access_token,
            'amount_total' => $this->amount_total,
            'currency' => $this->currency,
            'expires_at' => $this->expires_at,
        ];
    }
}