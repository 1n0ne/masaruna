<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Driver extends Model
{
    protected $fillable = [
        'name','email','phone','password','gender','city','street','type_id','university','car','seats','car_number','range','time','cost','image','code'
    ];        
   
}
