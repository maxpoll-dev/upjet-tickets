<?php

namespace App\Enums;

enum SeatStatus: string
{
    case FREE     = 'free';
    case OCCUPIED = 'occupied';
}