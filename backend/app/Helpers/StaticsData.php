<?php

namespace App\Helpers;
use Carbon\Carbon;
use Illuminate\Http\Request;
use LaravelFCM\Facades\FCM;
use LaravelFCM\Message\OptionsBuilder;
use LaravelFCM\Message\PayloadDataBuilder;
use LaravelFCM\Message\PayloadNotificationBuilder;
use TCG\Voyager\Voyager;
use URL;

class StaticsData
{
    public static function getSiteUrl()
    {
        return URL::to('/');
    }

    public static function getLocal(Request $request)
    {
        return ($request->hasHeader('X-localization')) ? $request->header('X-localization') : 'ar';
    }

    public static function getFullImageLink($image)
    {
        $voyager = new Voyager();
        return $voyager->image($image);
    }

    public static function getDateString($date)
    {
        if ($date instanceof Carbon) {
            return $date->toDateTimeString();
        } else {
            return $date;
        }
    }


    public static function sendMail($to, $message, $subject)
    {
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
        $headers .= "From: info@uthemes.com \r\n" .
            "Reply-To: info@uthemes.com \r\n" .
            "X-Mailer: PHP/" . phpversion();

        mail($to, $subject, $message, $headers);
    }

       public static $new_message_from = 4;


}
