<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['title'])]
class Movie extends Model
{
    /**
     * @return HasMany<MovieSession, $this>
     */
    public function movieSessions(): HasMany
    {
        return $this->hasMany(MovieSession::class);
    }
}