<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class ClientDay extends Model
{
    protected $fillable = [
        'client_id','day_id'
    ];         
}
