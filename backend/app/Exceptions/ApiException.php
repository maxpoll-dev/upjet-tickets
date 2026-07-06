<?php

namespace App\Exceptions;

use RuntimeException;

class ApiException extends RuntimeException
{
    /**
     * @param array<string, mixed> $context
     */
    public function __construct(
        public readonly string $errorCode,
        public readonly int $statusCode,
        string $message = '',
        public readonly array $context = [],
    ) {
        parent::__construct($message);
    }
}