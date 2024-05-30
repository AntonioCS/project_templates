<?php
declare(strict_types=1);

use Root\App\bla1;

require 'vendor/autoload.php';


spl_autoload_register(static function(string $class): void {
    echo $class , "\n";
    if ($class === 'Root\App\bla2') {
        require 'src/mocks/bla2.php';
    }
},true,true);

new bla1();