<?php

namespace App\Services;

use App\Models\Movie;
use Illuminate\Database\Eloquent\Collection;

class MovieService
{
    public function findAll(): Collection {
        return Movie::query()
            ->select('id', 'title')
            ->get();
    }

//  Дату намеренно зашил в код что бы не прокидывать с фронта
//  Так же еще есть проблема часового пояса. Ближе к ночи расхождение будет если UTC разный
//  Сервер работает в utc:0 и все входящие даты конвертим в utc:0 для вычислений - CarbonImmutable
    public function findById(string $id): Movie {
        return Movie::query()
            ->with([
                'movieSessions' => fn ($q) => $q
                    ->whereDate('starts_at', '>=', today())
                    ->orderBy('starts_at'),
            ])
            ->findOrFail((int) $id);
    }
}
