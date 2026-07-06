<?php

namespace App\Enums;

enum OrderStatus: string
{
    case RESERVED = 'reserved';
    case PENDING = 'pending';
    case PAID    = 'paid';
    case EXPIRED = 'expired';
}
