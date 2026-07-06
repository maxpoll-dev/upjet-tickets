<?php

namespace App\Http\Resources;

use App\Enums\SeatStatus;
use App\Models\Seat;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MovieSessionResource extends JsonResource
{
    /**
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'starts_at' => $this->starts_at,
            'price' => $this->price,
            'currency' => $this->currency,
            'movie' => $this->whenLoaded('movie', fn () => $this->movie->title),
            'room' => $this->whenLoaded('room', fn () => $this->room->name),
            'seats' => $this->when($this->seatsLoaded(), fn () => $this->seatMap()),
        ];
    }

    private function seatsLoaded(): bool
    {
        return $this->relationLoaded('tickets')
            && $this->relationLoaded('room')
            && $this->room->relationLoaded('seats');
    }

    /**
     * @return array<int, array{id: int, number: int, status: SeatStatus}>
     */
    private function seatMap(): array
    {
        $occupied = $this->tickets->pluck('seat_id')->all();

        return $this->room->seats
            ->map(fn (Seat $seat) => [
                'id' => $seat->id,
                'number' => $seat->number,
                'status' => in_array($seat->id, $occupied, true)
                    ? SeatStatus::OCCUPIED
                    : SeatStatus::FREE,
            ])
            ->all();
    }
}
