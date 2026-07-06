<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\CreateOrderRequest;
use App\Http\Resources\OrderCreatedResource;
use App\Http\Resources\OrderResource;
use App\Http\Resources\OrderPayResource;
use App\Models\Order;
use App\Services\OrderService;
use Illuminate\Http\JsonResponse;

class OrderController
{
    public function create(CreateOrderRequest $request, OrderService $orders): JsonResponse
    {
        return OrderCreatedResource::make($orders->create($request->validated()))
            ->response()
            ->setStatusCode(201);
    }

    public function getById(Order $order, OrderService $orders): OrderResource
    {
        return OrderResource::make($orders->getById($order));
    }

    public function pay(Order $order, OrderService $orders): JsonResponse
    {
        $orders->pay($order);

        return OrderPayResource::make($order)
            ->response()
            ->setStatusCode(202);
    }
}
