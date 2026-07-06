<?php

namespace App\Services;

use App\Models\MovieSession;

class MovieSessionService
{
    public function findById(int $id): MovieSession
    {
        return MovieSession::query()
            ->with([
                'movie',
                'room.seats' => fn ($query) => $query->orderBy('number'),
                'tickets',
            ])
            ->findOrFail($id);
    }
}