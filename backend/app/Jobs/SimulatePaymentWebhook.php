<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\RequestException;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Http;

class SimulatePaymentWebhook implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function __construct(private int $orderId) {}
    /**
     * Просто шлем статус и номер заказа.
     * Так же имитируем подпись.
     * @throws RequestException
     * @throws ConnectionException
     */
    public function handle(): void
    {
        $payload = [
            'type' => 'success',
            'order_id' => $this->orderId,
        ];

        Http::withHeaders([
            'X-Webhook-Secret' => (string) config('services.payment.webhook_secret'),
        ])->post((string) config('services.payment.webhook_url'), $payload)->throw();
    }
}
