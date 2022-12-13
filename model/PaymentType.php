<?php

use ActiveRecord\Model;

class PaymentType extends Model
{
    static $table_name = 'payment_type';

    const STATUS_ACTIVE = 'active';
    const STATUS_INACTIVE = 'inactive';

    const TYPE_INNER = 'inner';
    const TYPE_EXTERNAL = 'external';
}