<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class DriverSubscribe extends Model
{
    protected $fillable = [
        'driver_id','date','student_id'
    ];        
}
