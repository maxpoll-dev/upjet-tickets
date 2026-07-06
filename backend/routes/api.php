<?php

use App\Http\Controllers\Api\MovieController;
use App\Http\Controllers\Api\MovieSessionController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Webhook\PaymentController;
use App\Http\Middleware\VerifyOrderToken;
use Illuminate\Support\Facades\Route;

Route::get('/movies', [MovieController::class, 'findAll']);
Route::get('/movies/{id}', [MovieController::class, 'findById']);

Route::get('/sessions/{id}', [MovieSessionController::class, 'findById']);

Route::post('/orders', [OrderController::class, 'create']);
Route::get('/orders/{order}', [OrderController::class, 'getById'])->middleware(VerifyOrderToken::class);
Route::post('/orders/{order}/pay', [OrderController::class, 'pay'])->middleware(VerifyOrderToken::class);

Route::post('/webhooks/payment', [PaymentController::class, 'handle']);