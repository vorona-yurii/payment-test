<?php

use ActiveRecord\Model;

class PaymentSystem extends Model
{
    static $table_name = 'payment_system';

    const STATUS_ACTIVE = 'active';
    const STATUS_INACTIVE = 'inactive';
}