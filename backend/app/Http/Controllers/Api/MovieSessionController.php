<?php

namespace App\Http\Controllers\Api;

use App\Http\Resources\MovieSessionResource;
use App\Services\MovieSessionService;

class MovieSessionController
{
    public function findById(int $id, MovieSessionService $sessions): MovieSessionResource
    {
        return MovieSessionResource::make($sessions->findById($id));
    }
}