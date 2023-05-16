<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Rating extends Model
{
    protected $fillable = [
        'client_id','rate','suggestion'
    ];      
}
