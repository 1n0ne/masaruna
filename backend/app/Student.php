<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Student extends Model
{
    protected $fillable = [
        'name','email','phone','password','gender','city','street','home_number','lat','long','university','start_time','end_time','type_id'
    ];        
}
