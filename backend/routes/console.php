<?php

Schedule::command('app:expire-old-orders')
    ->everyMinute()
    ->withoutOverlapping();
