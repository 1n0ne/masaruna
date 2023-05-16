<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class DriverComplete extends Model
{
    protected $fillable = [
        'driver_id','date','student_id'
    ];        
}
