<?php

namespace App\Services;

use App\Enums\OrderStatus;
use App\Exceptions\ApiException;
use App\Jobs\SimulatePaymentWebhook;
use App\Models\MovieSession;
use App\Models\Order;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Throwable;

class OrderService
{
    /**
     * @param array{movie_session_id: int, email: string, seat_ids: array<int>} $data
     * @throws Throwable
     */
    public function create(array $data): Order
    {
        $session = MovieSession::findOrFail($data['movie_session_id']);
        $seatIds = array_values(array_unique($data['seat_ids']));

        $validSeats = $session->room->seats()->whereIn('id', $seatIds)->count();
        if ($validSeats !== count($seatIds)) {
            throw new ApiException('SEATS_INVALID', 422, 'Some seats do not belong to this session room.');
        }

        $taken = $session->tickets()->whereIn('seat_id', $seatIds)->pluck('seat_id');
        if ($taken->isNotEmpty()) {
            throw new ApiException('SEATS_TAKEN', 409, 'Some seats are already taken.', [
                'taken_seat_ids' => $taken->values()->all(),
            ]);
        }

        try {
            return DB::transaction(function () use ($session, $seatIds, $data) {
                $order = Order::create([
                    'access_token' => Str::random(40),
                    'email' => $data['email'],
                    'status' => OrderStatus::RESERVED,
                    'amount_total' => $session->price * count($seatIds),
                    'currency' => $session->currency,
                    'expires_at' => now()->addMinutes(10),
                ]);

                foreach ($seatIds as $seatId) {
                    $order->tickets()->create([
                        'movie_session_id' => $session->id,
                        'seat_id' => $seatId,
                    ]);
                }

                return $order;
            });
        } catch (QueryException $e) {
            if ($e->getCode() === '23505') {
                throw new ApiException('SEATS_TAKEN', 409, 'Some seats were just taken.');
            }
            throw $e;
        }
    }

    public function getById(Order $order): Order
    {
        return $order->load('tickets.seat', 'tickets.movieSession.movie', 'tickets.movieSession.room');
    }

    /**
     * @throws Throwable
     */
    public function pay(Order $order): void
    {
        if ($order->status !== OrderStatus::RESERVED) {
            throw new ApiException('ORDER_NOT_PAYABLE', 422, 'Order is not payable.', [
                'status' => $order->status->value,
            ]);
        }

        if ($order->expires_at !== null && $order->expires_at->isPast()) {
            throw new ApiException('ORDER_EXPIRED', 422, 'Order expired.');
        }

        $order->updateOrFail(['status' => OrderStatus::PENDING]);

        SimulatePaymentWebhook::dispatch($order->id)->delay(now()->addSeconds(60));
    }
}
