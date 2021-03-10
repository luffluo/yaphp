<?php

$tokens = token_get_all('<?php 1 + 2 + 3;');

foreach ($tokens as $token) {
    if (is_array($token)) {
        echo token_name($token[0]), " ('{$token[1]}')", PHP_EOL;
    } else {
        echo $token . PHP_EOL;
    }
}