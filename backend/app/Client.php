<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Client extends Model
{
    protected $fillable = [
        'name','email','phone','device_token','password','gender','city_id','street_id','home_number','lat','long','university_id','start_time','end_time','type_id','car','seats','car_number','range','time','cost','image','code'
    ];           
}


