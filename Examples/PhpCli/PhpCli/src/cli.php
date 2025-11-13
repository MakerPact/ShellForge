<?php

namespace App;

require_once __DIR__ . '/../vendor/autoload.php';

class CliApp
{
    public function run()
    {
        echo "Hello from PHP CLI App!\n";
    }
}

$app = new CliApp();
$app->run();
