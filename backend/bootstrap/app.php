<?php

use App\Exceptions\ApiException;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

// web вырезан
return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )

    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->trustProxies(at: '*'); // для https через риверс прокси
        $middleware->throttleApi('60,1'); // дефолт рейт лимит
    })

    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->is('api/*'),
        );

        $exceptions->render(fn (ApiException $e) => response()->json([
            'code' => $e->errorCode,
            'message' => $e->getMessage(),
            ...$e->context,
        ], $e->statusCode));

        $exceptions->render(fn (NotFoundHttpException $e, Request $request) => $request->is('api/*')
            ? response()->json(['code' => 'NOT_FOUND', 'message' => 'Resource not found.'], 404)
            : null);

        $exceptions->render(fn (ValidationException $e, Request $request) => $request->is('api/*')
            ? response()->json([
                'code' => 'VALIDATION',
                'message' => $e->getMessage(),
                'errors' => $e->errors(),
            ], 422)
            : null);
    })->create();
