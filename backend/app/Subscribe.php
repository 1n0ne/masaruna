<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Subscribe extends Model
{
    protected $fillable = [
        'driver_id','student_id','status','end_date'
    ];
}
