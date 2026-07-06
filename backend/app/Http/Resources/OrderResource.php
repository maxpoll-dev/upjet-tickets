<?php

namespace App\Http\Resources;

use App\Models\Ticket;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'order_id' => $this->id,
            'status' => $this->status,
            'email' => $this->email,
            'amount_total' => $this->amount_total,
            'currency' => $this->currency,
            'expires_at' => $this->expires_at,
            'paid_at' => $this->paid_at,
            'tickets' => $this->tickets->map(fn (Ticket $t) => [
                'seat_number' => $t->seat->number,
                'movie' => $t->movieSession->movie->title,
                'room' => $t->movieSession->room->name,
                'starts_at' => $t->movieSession->starts_at,
            ]),
        ];
    }
}
