<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('register_student', 'Api\AuthController@register_student');
Route::post('register_student_complete', 'Api\AuthController@register_student_complete');
Route::post('login_client', 'Api\AuthController@login_client');
Route::post('get_profile_client', 'Api\AuthController@get_profile_client');
Route::post('register_driver', 'Api\AuthController@register_driver');
Route::post('register_driver_complete', 'Api\AuthController@register_driver_complete');
Route::post('update_profile', 'Api\AuthController@update_profile');
Route::get('get_advertisment', 'Api\AuthController@get_advertisment');
Route::get('get_universities', 'Api\AuthController@get_universities');
Route::get('get_drivers', 'Api\AuthController@get_drivers');
Route::get('get_cities', 'Api\AuthController@get_cities');
Route::get('get_streets', 'Api\AuthController@get_streets');
Route::get('get_days', 'Api\AuthController@get_days');
Route::post('add_execuse', 'Api\AuthController@add_execuse');
Route::post('contact_us', 'Api\AuthController@contact_us');
Route::post('add_rating', 'Api\AuthController@add_rating');
Route::post('update_password', 'Api\AuthController@update_password');
Route::post('update_profile', 'Api\AuthController@update_profile');
Route::get('get_drivers', 'Api\AuthController@get_drivers');
Route::post('add_subscribe', 'Api\SubscribeController@add_subscribe');
Route::post('update_subscribe', 'Api\SubscribeController@update_subscribe');
Route::post('get_student_subscribe', 'Api\SubscribeController@get_student_subscribe');
Route::post('get_driver_subscribe', 'Api\SubscribeController@get_driver_subscribe');
Route::post('get_wait_driver_subscribe', 'Api\SubscribeController@get_wait_driver_subscribe');
Route::post('get_accepted_driver_subscribe', 'Api\SubscribeController@get_accepted_driver_subscribe');
Route::post('add_driver_rate', 'Api\SubscribeController@add_driver_rate');
Route::post('add_student_rate', 'Api\SubscribeController@add_student_rate');
Route::post('add_student_list', 'Api\SubscribeController@add_student_list');
Route::post('delete_from_student_list', 'Api\SubscribeController@delete_from_student_list');
/////////////////////////////////////////////////////////////////////////////////////////////////
Route::post('get_subscribed_drivers', 'Api\SubscribeController@get_subscribed_drivers');
Route::post('get_student_rate', 'Api\SubscribeController@get_student_rate');
Route::post('get_driver_rate', 'Api\SubscribeController@get_driver_rate');
Route::post('get_unsubscribed_drivers', 'Api\SubscribeController@get_unsubscribed_drivers');
Route::post('delete_day', 'Api\AuthController@delete_day');
Route::post('get_my_days', 'Api\AuthController@get_my_days');
Route::post('add_days', 'Api\AuthController@add_days');
Route::post('forget_password', 'Api\AuthController@forget_password');
Route::post('update_fcm', 'Api\AuthController@update_fcm');
Route::post('sendNotification', 'Api\AuthController@sendNotification');
Route::post('get_driver_execuse', 'Api\AuthController@get_driver_execuse');
Route::post('get_client_notifications', 'Api\SubscribeController@get_client_notifications');
Route::post('delete_client', 'Api\AuthController@delete_client');
Route::post('get_cost_drivers', 'Api\AuthController@get_cost_drivers');
Route::post('get_rate_drivers', 'Api\AuthController@get_rate_drivers');
/////////////////////////////////////////////////////////////////////////////////////////////////
Route::post('add_student_complete_list', 'Api\SubscribeController@add_student_complete_list');
Route::post('get_student_list', 'Api\SubscribeController@get_student_list');
Route::post('update_location', 'Api\AuthController@update_location');
Route::post('get_student_subscribe_count', 'Api\SubscribeController@get_student_subscribe_count');
Route::post('get_city_drivers', 'Api\AuthController@get_city_drivers');
Route::post('get_client_date_notifications', 'Api\SubscribeController@get_client_date_notifications');






Route::group(['middleware' => 'auth:api'], function () {
});
