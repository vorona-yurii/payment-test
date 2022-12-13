<?php

const PRODUCT_TYPE_BOOK = 'book';
const PRODUCT_TYPE_REWARD = 'reward';
const PRODUCT_TYPE_WALLET_REFILL = 'walletRefill';

const LANG_EN = 'en';
const LANG_ES = 'es';
const LANG_UK = 'uk';

const OS_ANDROID = 'android';
const OS_IOS = 'ios';
const OS_WINDOWS = 'windows';

const DB_CON = 'mysql';
const DB_HOST = 'localhost';
const DB_USER = 'root';
const DB_PASSWORD = '';
const DB_TABLE = 'payment_test';

ActiveRecord\Config::initialize(function ($cfg) {
    $cfg->set_model_directory('models');
    $cfg->set_connections([
        'development' => sprintf('%s://%s:%s@%s/%s?charset=utf8', DB_CON, DB_USER, DB_PASSWORD, DB_HOST, DB_TABLE)
    ]);
});