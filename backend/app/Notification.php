<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


class Notification extends Model
{
    protected $fillable = [
        'client_id','title','body','status'
    ];         
}
