<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Image extends Model
{
    protected $fillable = [
       'au_id','s_date','e_date','path','note','state','result'
    ];
}
