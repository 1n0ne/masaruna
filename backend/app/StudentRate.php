<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class StudentRate extends Model
{
    protected $fillable = [
        'driver_id','rate','student_id','subscribe_id'
    ];        
       
}
