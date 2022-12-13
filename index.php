<?php

require_once 'vendor/autoload.php';
require_once 'config.php';
require_once 'model/Country.php';
require_once 'model/PaymentSystem.php';
require_once 'model/PaymentType.php';
require_once 'PaymentTypeSelector.php';

$productType        = 'book';
$amount             = 0.299;
$lang               = 'es';
$countryCode        = 'IN';
$userOs             = 'android';

$paymentTypeSelector = new PaymentTypeSelector($productType, $amount, $lang, $countryCode, $userOs);
$paymentButtons = $paymentTypeSelector->getButtons();

echo '<pre>';
var_dump($paymentButtons);
echo '</pre>';