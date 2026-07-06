<?php

namespace Database\Seeders;

use App\Enums\Currency;
use App\Enums\OrderStatus;
use App\Models\Movie;
use App\Models\MovieSession;
use App\Models\Order;
use App\Models\Room;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $movies = collect([
            'Начало', 'Матрица', 'Интерстеллар', 'Побег из Шоушенка',
            'Форрест Гамп', 'Гладиатор', 'Крёстный отец', 'Бойцовский клуб',
            'Зелёная миля',
        ])->map(fn (string $title) => Movie::create(['title' => $title]));

        $rooms = collect(['Зал большой', 'Зал средний', 'Зал малый'])
            ->map(function (string $name) {
                $room = Room::create(['name' => $name]);

                foreach (range(1, 10) as $number) {
                    $room->seats()->create(['number' => $number]);
                }

                return $room;
            });

        foreach ($rooms as $room) {
            $seats = $room->seats;

            for ($hour = 10; $hour < 24; $hour += 4) {
                $session = MovieSession::create([
                    'movie_id' => $movies->random()->id,
                    'room_id' => $room->id,
                    'starts_at' => today()->setTime($hour, 0),
                    'price' => 1000,
                    'currency' => Currency::RUB,
                ]);

                $occupied = $seats->random(rand(0, $seats->count()));
                if ($occupied->isEmpty()) {
                    continue;
                }

                // Одна оплаченная бронь на сеанс, чтобы часть мест была занята
                $order = Order::create([
                    'access_token' => Str::random(40),
                    'email' => fake()->safeEmail(),
                    'status' => OrderStatus::PAID,
                    'amount_total' => $session->price * $occupied->count(),
                    'currency' => $session->currency,
                    'paid_at' => now(),
                ]);

                foreach ($occupied as $seat) {
                    $order->tickets()->create([
                        'movie_session_id' => $session->id,
                        'seat_id' => $seat->id,
                    ]);
                }
            }
        }
    }
}
