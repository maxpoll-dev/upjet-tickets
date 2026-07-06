<?php

Schedule::command('app:expire-old-orders')
    ->everyFiveMinutes()
    ->withoutOverlapping();
