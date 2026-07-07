<?php

namespace App\Http\Controllers\Webhook;

use App\Enums\OrderStatus;
use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PaymentController
{
    public function handle(Request $request): Response
    {
        abort_unless(
            hash_equals(
                (string) config('services.payment.webhook_secret'),
                (string) $request->header('X-Webhook-Secret')
            ),
            403
        );

        if ($request->input('type') !== 'success') {
            return response()->noContent();
        }

        $order = Order::find($request->input('order_id'));

        if ($order !== null && $order->status === OrderStatus::PENDING) {
            $order->update(['status' => OrderStatus::PAID, 'paid_at' => now()]);
        }

        return response()->noContent();
    }
}
