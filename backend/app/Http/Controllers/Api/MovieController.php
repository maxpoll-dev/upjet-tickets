<?php

namespace App\Http\Controllers\Api;

use App\Http\Resources\MovieResource;
use App\Services\MovieService;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class MovieController
{
    public function findAll(MovieService $movies): AnonymousResourceCollection
    {
        return MovieResource::collection($movies->findAll());
    }

    public function findById(string $id, MovieService $movies): MovieResource
    {
        return MovieResource::make($movies->findById($id));
    }
}
