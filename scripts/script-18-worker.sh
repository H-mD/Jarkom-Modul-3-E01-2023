#!/bin/bash

echo -e "
Route::get('/worker1', function () {
    \$hostname = gethostname();
    return \"Ini \$hostname\";

});
" >> /var/www/laravel-praktikum-jarkom/routes/web.php

service nginx restart