<?php

namespace App\Console\Commands;

use App\Enums\OrderStatus;
use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use App\Models\Order;
use Illuminate\Support\Facades\DB;
use Throwable;

#[Signature('app:expire-old-orders')]
#[Description('Set expired orders after 10 minutes.')]
class ExpireOldOrders extends Command
{
    /**
     * @throws Throwable
     */
    public function handle()
    {
        $expiredOrders = Order::where('status', OrderStatus::RESERVED)
            ->where('expires_at', '<', now())
            ->limit(100)
            ->get();

        foreach ($expiredOrders as $order) {
            DB::transaction(function () use ($order) {
                $order->update(['status' => OrderStatus::EXPIRED]);
                $order->tickets()->delete();
            });
        }

        $this->info("Expired {$expiredOrders->count()} orders.");
    }
}
