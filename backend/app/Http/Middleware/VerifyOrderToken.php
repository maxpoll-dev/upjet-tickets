<?php

namespace App\Http\Middleware;

use App\Exceptions\ApiException;
use App\Models\Order;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class VerifyOrderToken
{
    public function handle(Request $request, Closure $next): Response
    {
        $order = $request->route('order');

        if (!$order instanceof Order
            || ! hash_equals($order->access_token, (string) $request->query('token'))) {
            throw new ApiException('NOT_FOUND', 404, 'Order not found.');
        }

        return $next($request);
    }
}
