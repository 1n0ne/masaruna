<?php

namespace App\Http\Controllers\Api;

use App\City;
use App\Client;
use App\Driver;
use App\DriverComplete;
use App\DriverRate;
use App\DriverSubscribe;
use App\Execus;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;
use App\Notification;
use App\Street;
use App\Student;
use App\StudentRate;
use App\Subscribe;
use App\University;
use Illuminate\Http\Request;
use Validator;
use App\User;
use Carbon\Carbon;
use Hamcrest\Core\IsNull;
use Illuminate\Support\Facades\Auth;

class SubscribeController extends Controller
{
    public $successStatus = 200;
    // اضافة اشتراك
    public function add_subscribe(Request $request)
    {
        $rules = [
            'driver_id' => 'required',
            'student_id' => 'required',
            'end_date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();
        $subscribecount = Subscribe::Where('student_id', $input['student_id'])->Where('driver_id', $input['driver_id'])->Where('status', '!=', 4)->Where('status', '!=', 3)->count();
        if ($subscribecount == 0) {
            try {

                $subscribe = Subscribe::create($input);
            } catch (Exception $e) {
                return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
            }


            $data['id'] = $subscribe->id;
            $data['student_id'] = $subscribe->student_id;
            $data['driver_id'] = $subscribe->driver_id;
            $data['end_date'] = $subscribe->end_date;
            $subscribe = Subscribe::where('id', $data['id'])->get()->first();
            $data['status'] = $subscribe->status;
            // 0 انتظار
            // 1 دفع
            // 2 مشترك
            // 3 انتهى الاشتراك
            // 4 تم الرفض

            return response()->json(
                [
                    'status' => '1',
                    'data' => $data,
                    'message' => 'Successfully added subscribe !'
                ],
                $this->successStatus
            );
        } else {
            $data = [];
            return response()->json(
                [
                    'status' => '-1',
                    'data' => $data,
                    'message' => 'failed added subscribe !'
                ],
                $this->successStatus
            );
        }
    }

    public function update_subscribe(Request $request)
    {
        $rules = [
            'id' => 'required',
            'status' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribe = Subscribe::WHERE('id', $input['id'])->update($input);
            $subscribe = Subscribe::WHERE('id', $input['id'])->get()->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $subscribe->id;
        $data['student_id'] = $subscribe->student_id;
        $data['driver_id'] = $subscribe->driver_id;
        $data['end_date'] = $subscribe->end_date;
        $data['status'] = $subscribe->status;


        $firebaseToken = Client::where('id', $data['student_id'])->whereNotNull('device_token')->pluck('device_token')->all();

        $SERVER_API_KEY = env('FCM_SERVER_KEY');

        $input = $request->all();
        $title = "الحالة";
        $body = "تم تحديث حالتك";
        $data2 = [
            "registration_ids" => $firebaseToken,
            "notification" => [
                "title" => $title,
                "body" => $body,
            ]
        ];
        $dataString = json_encode($data2);

        $headers = [
            'Authorization: key=' . $SERVER_API_KEY,
            'Content-Type: application/json',
        ];

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $dataString);

        $response = curl_exec($ch);


        // 0 انتظار
        // 1 دفع
        // 2 مشترك
        // 3 انتهى الاشتراك
        // 4 تم الرفض

        $value = [];
        $value['title'] = $title;
        $value['body'] = $body;
        $value['client_id'] = $subscribe->student_id;
        $value['status'] = $subscribe->status;


        $notification = Notification::create($value);

        $data['title'] = $notification->title;
        $data['body'] = $notification->body;
        $data['notification_id'] = $notification->id;
        $data['notification_status'] = $notification->status;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully updated subscribe !'
            ],
            $this->successStatus
        );
    }

    // استرجاع اشتراكات الطالب
    public function get_student_subscribe(Request $request)
    {


        $rules = [
            'student_id' => 'required',
            'date' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribes = Subscribe::Where('student_id', $input['student_id'])->Where('status', '!=', 4)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $student=Client::WHERE('id',$input['student_id'])->get()->first();
        $lat1 = $student->lat;
        $lon1 = $student->long;
        $i = 0;
        $data = [];
        foreach ($subscribes as $subscribe) {

            $execuse = Execus::Where('date', $input['date'])->Where('client_id',  $subscribe->student_id)->count();
            if (1) {
                $data[$i]['id'] = $subscribe->id;
                $data[$i]['student_id'] = $subscribe->student_id;
                $data[$i]['driver_id'] = $subscribe->driver_id;
                $student_list = DriverSubscribe::where('student_id', $subscribe->student_id)->where('driver_id', $subscribe->driver_id)->where('date', $input['date'])->count();
                if ($student_list == 0) {
                    $state = 0;
                } else {
                    $state = 1;
                }
                $student_complete = DriverComplete::where('student_id',  $subscribe->student_id)->where('driver_id', $subscribe->driver_id)->where('date', $input['date'])->count();
                if ($student_complete != 0) {
                    $state = 2;
                }
                $data[$i]['state'] = $state;
    

                $execuse = Execus::Where('date', $input['date'])->Where('client_id',  $subscribe->driver_id)->count();
if($execuse==0)
{
    $data[$i]['execuse'] = $execuse;
}
else
{
    $data[$i]['execuse'] = 1;
}
                $driver = Client::WHERE('id', $data[$i]['driver_id'])->get()->first();
                $lat2 = $driver->lat;
                $lon2 = $driver->long;
                $theta = $lon1 - $lon2;
                $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1))
                    * cos(deg2rad($lat2)) * cos(deg2rad($theta));
                $dist = acos($dist);
                $dist = rad2deg($dist);
                $miles = $dist * 60 * 1.1515;
                $kilometers = $miles * 1.609344;
                $data[$i]['kilometers'] = $kilometers;
                $client = Client::Where('id', $data[$i]['driver_id'])
                    ->get()->first();
                $data[$i]['client_id'] = $client->id;
                $data[$i]['name'] = $client->name;
                $data[$i]['email'] = $client->email;
                $data[$i]['phone'] = $client->phone;
                $data[$i]['password'] = $client->password;
                $data[$i]['gender'] = $client->gender;
                $data[$i]['home_number'] = $client->home_number;
                $data[$i]['lat'] = $client->lat;
                $data[$i]['long'] = $client->long;
                $data[$i]['image'] = $client->image;
                $data[$i]['start_time'] = $client->start_time;
                $data[$i]['end_time'] = $client->end_time;
                $data[$i][$i]['type_id'] = $client->type_id;
                $type_id = $client->type_id;
                if ($type_id == 1) {
                    $type = "طالب";
                }
                if ($type_id == 2) {
                    $type = "سائق باص";
                }
                if ($type_id == 3) {
                    $type = "ولي أمر";
                }

                $data[$i]['type'] = $type;
                $data[$i]['city_id'] = $client->city_id;
                $city = City::WHERE('id', $data[$i]['city_id'])->first();
                $data[$i]['city_name'] = $city->name;
                $data[$i]['street_id'] = $client->street_id;
                $street = Street::WHERE('id', $data[$i]['street_id'])->first();
                $data[$i]['street_name'] = $street->name;
                $data[$i]['university_id'] = $client->university_id;
                $university = University::WHERE('id', $data[$i]['university_id'])->first();
                $data[$i]['university_name'] = $university->name;
                $data[$i]['car'] = $client->car;
                $data[$i]['seats'] = $client->seats;
                $data[$i]['car_number'] = $client->car_number;
                $data[$i]['time'] = $client->time;
                $data[$i]['range'] = $client->range;
                $data[$i]['cost'] = $client->cost;
                $data[$i]['code'] = $client->code;
                $data[$i]['image'] = $client->image;
                $data[$i]['device_token'] = $client->device_token;

                $data[$i]['status'] = $subscribe->status;
                $i++;
            }
   

        }

        $sortedArr=[];
        $unsortedData = collect($data);
        $sortedData = $unsortedData->sortBy('kilometers');
        $sortedArray  = $sortedData->all();
        $j=0;
foreach($sortedArray as $sorted)
{
$sortedArr[$j]=$sorted;
$j++;
}
        return response()->json(
            [
                'status' => '1',
                'data' => $sortedArr  ,
                'message' => 'Successfully get subscribes!'
            ],
            $this->successStatus
        );
    }

    // استرجاع اشتراكات الطالب
    public function get_student_subscribe_count(Request $request)
    {


        $rules = [
            'student_id' => 'required',
            'date' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribescount = Subscribe::Where('student_id', $input['student_id'])->Where('status', '!=', 3)->Where('status', '!=', 4)->count();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

     if($subscribescount==0){
$count=0;
     }  
     else
     {
        $count=1;
     }
        $data = [];
       $data['count']=$count;
        return response()->json(
            [
                'status' => '1',
                'data' => $data  ,
                'message' => 'Successfully get subscribes!'
            ],
            $this->successStatus
        );
    }

    
    // استرجاع اشتراكات للسائق
    public function get_driver_subscribe(Request $request)
    {


        $rules = [
            'driver_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribes = Subscribe::Where('driver_id', $input['driver_id'])->Where('status', '!=', 4)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($subscribes as $subscribe) {
            
                     if(StudentRate::where('student_id' ,$subscribe->student_id)->where('driver_id', $input['driver_id'])->count() > 0 ) continue;
            
            
            
            
            $data[$i]['id'] = $subscribe->id;
            $data[$i]['student_id'] = $subscribe->student_id;
            $execuse = Execus::Where('date', $input['date'])->Where('client_id',  $subscribe->student_id)->count();
            if($execuse==0)
            {
                $data[$i]['execuse'] = $execuse;
            }
            else
            {
                $data[$i]['execuse'] = 1;
            }
            $client = Client::Where('id', $data[$i]['student_id'])
                ->get()->first();
            $data[$i]['client_id'] = $client->id;
            $data[$i]['name'] = $client->name;
            $data[$i]['email'] = $client->email;
            $data[$i]['phone'] = $client->phone;
            $data[$i]['password'] = $client->password;
            $data[$i]['gender'] = $client->gender;
            $data[$i]['home_number'] = $client->home_number;
            $data[$i]['lat'] = $client->lat;
            $data[$i]['long'] = $client->long;
            $data[$i]['image'] = $client->image;
            $data[$i]['start_time'] = $client->start_time;
            $data[$i]['end_time'] = $client->end_time;
            $data[$i][$i]['type_id'] = $client->type_id;
            $type_id = $client->type_id;
            if ($type_id == 1) {
                $type = "طالب";
            }
            if ($type_id == 2) {
                $type = "سائق باص";
            }
            if ($type_id == 3) {
                $type = "ولي أمر";
            }

            $data[$i]['type'] = $type;
            $data[$i]['city_id'] = $client->city_id;
            $city = City::WHERE('id', $data[$i]['city_id'])->first();
            $data[$i]['city_name'] = $city->name;
            $data[$i]['street_id'] = $client->street_id;
            $street = Street::WHERE('id', $data[$i]['street_id'])->first();
            $data[$i]['street_name'] = $street->name;
            $data[$i]['university_id'] = $client->university_id;
            $university = University::WHERE('id', $data[$i]['university_id'])->first();
            $data[$i]['university_name'] = $university->name;
            $data[$i]['car'] = $client->car;
            $data[$i]['seats'] = $client->seats;
            $data[$i]['car_number'] = $client->car_number;
            $data[$i]['time'] = $client->time;
            $data[$i]['range'] = $client->range;
            $data[$i]['cost'] = $client->cost;
            $data[$i]['code'] = $client->code;
            $data[$i]['image'] = $client->image;

            $data[$i]['driver_id'] = $subscribe->driver_id;
            $data[$i]['status'] = $subscribe->status;
            $data[$i]['end_date'] = $subscribe->end_date;
            $data[$i]['device_token'] = $client->device_token;


            $countrate = StudentRate::where('student_id',  $data[$i]['student_id'])->count();
            if ($countrate != 0) {
                $rates = StudentRate::where('student_id',  $data[$i]['student_id'])->get();
                $j = 0;
                $sum = 0;
                foreach ($rates as $rate) {
                    $sum = $sum + $rate->rate;
                    $j++;
                }
                $avg = $sum / $j;
                $data[$i]['avg'] = $avg;
            } else {
                $data[$i]['avg'] = 0;
            }




            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get subscribes!'
            ],
            $this->successStatus
        );
    }

    // استرجاع الاشتراكات التي تنتظر الموافقة للسائق
    public function get_wait_driver_subscribe(Request $request)
    {


        $rules = [
            'driver_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribes = Subscribe::Where('driver_id', $input['driver_id'])->Where('status', 0)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($subscribes as $subscribe) {
            $data[$i]['id'] = $subscribe->id;
            $data[$i]['student_id'] = $subscribe->student_id;
            $data[$i]['driver_id'] = $subscribe->driver_id;
            $data[$i]['status'] = $subscribe->status;
            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get subscribes!'
            ],
            $this->successStatus
        );
    }



    //  اضافة تقييم للسائق

    public function add_driver_rate(Request $request)
    {
        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'rate' => 'required',
            'subscribe_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $driverrate = DriverRate::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $driverrate->id;
        $data['student_id'] = $driverrate->student_id;
        $data['driver_id'] = $driverrate->driver_id;
        $data['rate'] = $driverrate->rate;
        $data['subscribe_id'] = $driverrate->subscribe_id;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added rate !'
            ],
            $this->successStatus
        );
    }

    //  اضافة تقييم للطالب

    public function add_student_rate(Request $request)
    {
        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'rate' => 'required',
            'subscribe_id' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $studentRate = StudentRate::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $studentRate->id;
        $data['student_id'] = $studentRate->student_id;
        $data['driver_id'] = $studentRate->driver_id;
        $data['rate'] = $studentRate->rate;
        $data['subscribe_id'] = $studentRate->subscribe_id;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added rate !'
            ],
            $this->successStatus
        );
    }


    // استرجاع الاشتراكات الموافق عليها الخاصة بالسائق
    public function get_accepted_driver_subscribe(Request $request)
    {




        $rules = [
            'driver_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $subscribes = Subscribe::Where('driver_id', $input['driver_id'])->Where('status', 2)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $driver = Client::WHERE('id', $input['driver_id'])->get()->first();
        $lat1 = $driver->lat;
        $lon1 = $driver->long;

        // $lat1,$lat2,$lon1,$lon2

        // $theta = $lon1 - $lon2;
        // $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1))
        //  * cos(deg2rad($lat2)) * cos(deg2rad($theta));
        // $dist = acos($dist);
        // $dist = rad2deg($dist);
        // $miles = $dist * 60 * 1.1515;
        // $kilometers=$miles * 1.609344;


        $i = 0;
        $data = [];
        foreach ($subscribes as $subscribe) {
            $student_list = DriverSubscribe::where('student_id', $subscribe->student_id)->where('driver_id', $input['driver_id'])->where('date', $input['date'])->count();
            if ($student_list == 0) {
                $state = 0;
            } else {
                $state = 1;
            }
            $student_complete = DriverComplete::where('student_id',  $subscribe->student_id)->where('driver_id', $input['driver_id'])->where('date', $input['date'])->count();
            if ($student_complete != 0) {
                $state = 2;
            }
// 2 تم التوصيل
            $data[$i]['id'] = $subscribe->id;
            $data[$i]['student_id'] = $subscribe->student_id;
            $execuse = Execus::Where('date', $input['date'])->Where('client_id',  $subscribe->student_id)->count();
        if($execuse==0){
            $data[$i]['execuse'] = $execuse;
        }
        else
{
    $data[$i]['execuse'] = 1;
}


if($execuse > 0) continue;
            $student = Client::WHERE('id', $subscribe->student_id)->get()->first();
            $data[$i]['student_name'] = $student->name;
            $data[$i]['student_phone'] = $student->phone;
            $data[$i]['student_lat'] = $student->lat;
            $data[$i]['student_long'] = $student->long;
            $lat2 = $student->lat;
            $lon2 = $student->long;
            $theta = $lon1 - $lon2;
            $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1))
                * cos(deg2rad($lat2)) * cos(deg2rad($theta));
            $dist = acos($dist);
            $dist = rad2deg($dist);
            $miles = $dist * 60 * 1.1515;
            $kilometers = $miles * 1.609344;
            $data[$i]['kilometers'] = $kilometers;
            $data[$i]['start_time'] = $student->start_time;
            $data[$i]['end_time'] = $student->end_time;
            $data[$i]['city_id'] = $student->city_id;
            $city = City::WHERE('id', $student->city_id)->get()->first();
            $data[$i]['city'] = $city->name;
            $data[$i]['street_id'] = $student->street_id;
            $street = Street::WHERE('id', $student->street_id)->get()->first();
            $data[$i]['street'] = $street->name;
            $data[$i]['university_id'] = $student->university_id;
            $university = University::WHERE('id', $student->university_id)->get()->first();
            $data[$i]['university'] = $university->name;
            $countrate = DriverRate::where('student_id', $student->id)->Where('subscribe_id', $subscribe->id)->count();
            if ($countrate != 0) {
                $rate = DriverRate::where('student_id', $student->id)->Where('subscribe_id', $subscribe->id)->get()->first();
                $data[$i]['user_rate'] = $rate->rate;
            } else {
                $data[$i]['user_rate'] = 0;
            }
            $data[$i]['driver_id'] = $subscribe->driver_id;
            $data[$i]['status'] = $subscribe->status;
            $data[$i]['state'] = $state;

            $i++;
        }

        $unsortedData = collect($data);
        $sortedData = $unsortedData->sortBy('kilometers');
        $sortedArray  = $sortedData->all();
        $j=0;
        $sortedArr=[];
foreach($sortedArray as $sorted)
{
$sortedArr[$j]=$sorted;
$j++;
}
 



        return response()->json(
            [
                'status' => '1',
                'data' => $sortedArr,
                'message' => 'Successfully get subscribes!'
            ],
            $this->successStatus
        );
    }

    // اضافة الى قائمة قيد الانتظار

    public function add_student_list(Request $request)
    {
        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $driver_subscribe = DriverSubscribe::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $driver_subscribe->id;
        $data['student_id'] = $driver_subscribe->student_id;
        $data['driver_id'] = $driver_subscribe->driver_id;
        $data['date'] = $driver_subscribe->date;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added rate !'
            ],
            $this->successStatus
        );
    }


    // اضافة الى قائمة تم التوصيل

    public function add_student_complete_list(Request $request)
    {
        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $driver_complete = DriverComplete::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $driver_complete->id;
        $data['student_id'] = $driver_complete->student_id;
        $data['driver_id'] = $driver_complete->driver_id;
        $data['date'] = $driver_complete->date;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added tour complete !'
            ],
            $this->successStatus
        );
    }



    // استرجاع اذا كان مستخدم قيد الانتظار او لا

    public function get_student_list(Request $request)
    {

        // 0 عالطريق
        // 1 قيد الانتظار
        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $student_list = DriverSubscribe::where('student_id', $input['student_id'])->where('driver_id', $input['driver_id'])->where('date', $input['date'])->count();
            $student_complete = DriverComplete::where('student_id', $input['student_id'])->where('driver_id', $input['driver_id'])->where('date', $input['date'])->count();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }


        $data['list'] = $student_list;
        $data['complete'] = $student_complete;

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully  returned !'
            ],
            $this->successStatus
        );
    }

   



    public function delete_from_student_list(Request $request)
    {


        $rules = [
            'student_id' => 'required',
            'driver_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $student_delete = DriverSubscribe::where('student_id', $input['student_id'])->where('driver_id', $input['driver_id'])->where('date', $input['date'])->delete();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }


        $data['student_delete'] = $student_delete;

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully  deleted !'
            ],
            $this->successStatus
        );
    }


    // ارجاع السائقين المشترك معهم


    public function get_subscribed_drivers(Request $request)
    {

        $rules = [
            'student_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();


        try {
            $drivers = Client::Where('type_id', 2)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($drivers as $driver) {
            $subscribes_count = Subscribe::Where('student_id', $input['student_id'])
                ->Where('driver_id', $driver['id'])
                ->whereDate('end_date', ">=", $input['date'])->count();
            // whereDate('date', '<=', '2014-07-10')
            if ($subscribes_count != 0) {
                $data[$i]['id'] = $driver->id;
                $data[$i]['name'] = $driver->name;
                $data[$i]['email'] = $driver->email;
                $data[$i]['phone'] = $driver->phone;
                $data[$i]['password'] = $driver->password;
                $data[$i]['gender'] = $driver->gender;
                $data[$i]['city_id'] = $driver->city_id;
                $city = City::WHERE('id', $data[$i]['city_id'])->first();
                $data[$i]['city_name'] = $city->name;
                $data[$i]['street_id'] = $driver->street_id;
                $street = Street::WHERE('id', $data[$i]['street_id'])->first();
                $data[$i]['street_name'] = $street->name;
                $data[$i]['university_id'] = $driver->university_id;
                $university = University::WHERE('id', $data[$i]['university_id'])->first();
                $data[$i]['university_name'] = $university->name;
                $data[$i]['car'] = $driver->car;
                $data[$i]['seats'] = $driver->seats;
                $data[$i]['car_number'] = $driver->car_number;
                $data[$i]['time'] = $driver->time;
                $data[$i]['range'] = $driver->range;
                $data[$i]['cost'] = $driver->cost;
                $data[$i]['code'] = $driver->code;
                $data[$i]['image'] = $driver->image;

                $data[$i]['type_id'] = $driver->type_id;
                $type_id = $driver->type_id;
                if ($type_id == 1) {
                    $type = "طالب";
                }
                if ($type_id == 2) {
                    $type = "سائق باص";
                }
                if ($type_id == 3) {
                    $type = "ولي أمر";
                }
                $data[$i]['type'] = $type;
            }
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get drivers!'
            ],
            $this->successStatus
        );
    }



    // ارجاع السائقين الذين ليس مشترك معهم

    public function get_unsubscribed_drivers(Request $request)
    {

        $rules = [
            'student_id' => 'required',
            'date' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();


        try {
            $drivers = Client::Where('type_id', 2)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($drivers as $driver) {
            $subscribes_count = Subscribe::Where('student_id', $input['student_id'])
                ->Where('driver_id', $driver['id'])
                ->whereDate('end_date', ">=", $input['date'])->count();
            // ->Where($input['date']->gt('date'))->count();

            if ($subscribes_count != 0) {
                $data[$i]['id'] = $driver->id;
                $data[$i]['name'] = $driver->name;
                $data[$i]['email'] = $driver->email;
                $data[$i]['phone'] = $driver->phone;
                $data[$i]['password'] = $driver->password;
                $data[$i]['gender'] = $driver->gender;
                $data[$i]['city_id'] = $driver->city_id;
                $city = City::WHERE('id', $data[$i]['city_id'])->first();
                $data[$i]['city_name'] = $city->name;
                $data[$i]['street_id'] = $driver->street_id;
                $street = Street::WHERE('id', $data[$i]['street_id'])->first();
                $data[$i]['street_name'] = $street->name;
                $data[$i]['university_id'] = $driver->university_id;
                $university = University::WHERE('id', $data[$i]['university_id'])->first();
                $data[$i]['university_name'] = $university->name;
                $data[$i]['car'] = $driver->car;
                $data[$i]['seats'] = $driver->seats;
                $data[$i]['car_number'] = $driver->car_number;
                $data[$i]['time'] = $driver->time;
                $data[$i]['range'] = $driver->range;
                $data[$i]['cost'] = $driver->cost;
                $data[$i]['code'] = $driver->code;
                $data[$i]['image'] = $driver->image;

                $data[$i]['type_id'] = $driver->type_id;
                $type_id = $driver->type_id;
                if ($type_id == 1) {
                    $type = "طالب";
                }
                if ($type_id == 2) {
                    $type = "سائق باص";
                }
                if ($type_id == 3) {
                    $type = "ولي أمر";
                }
                $data[$i]['type'] = $type;
            }
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get drivers!'
            ],
            $this->successStatus
        );
    }






    // تقييم السائق
    public function get_driver_rate(Request $request)
    {


        $rules = [
            'driver_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $data = [];

            $countrate = DriverRate::where('driver_id',  $input['driver_id'])->count();
            if ($countrate != 0) {
                $rates = DriverRate::where('driver_id',  $input['driver_id'])->get();
                $i = 0;
                $sum = 0;
                foreach ($rates as $rate) {
                    $sum = $sum + $rate->rate;
                    $i++;
                }
                $avg = $sum / $i;
                $data['avg'] = $avg;
            } else {
                $data['avg'] = 0;
            }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }




        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get average!'
            ],
            $this->successStatus
        );
    }

    // تقييم الطالب
    public function get_student_rate(Request $request)
    {


        $rules = [
            'student_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $data = [];

            $countrate = StudentRate::where('student_id',  $input['student_id'])->count();
            if ($countrate != 0) {
                $rates = StudentRate::where('student_id',  $input['student_id'])->get();
                $i = 0;
                $sum = 0;
                foreach ($rates as $rate) {
                    $sum = $sum + $rate->rate;
                    $i++;
                }
                $avg = $sum / $i;
                $data['avg'] = $avg;
            } else {
                $data['avg'] = 0;
            }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }




        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get average!'
            ],
            $this->successStatus
        );
    }












    // استرجاع اشعارات المستخدم 
    public function get_client_notifications(Request $request)
    {


        $rules = [
            'client_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $notifications = Notification::Where('client_id', $input['client_id'])->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($notifications as $notification) {
            $data[$i]['id'] = $notification->id;
            $data[$i]['title'] = $notification->title;
            $data[$i]['body'] = $notification->body;
            $data[$i]['client_id'] = $notification->client_id;
            $data[$i]['status'] = $notification->status;
            $i++;
        }

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get notifications!'
            ],
            $this->successStatus
        );
    }



    // استرجاع اشعارات المستخدم 
    public function get_client_date_notifications(Request $request)
    {


        $rules = [
            'client_id' => 'required',
            'date' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $notifications = Notification::Where('client_id', $input['client_id'])->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($notifications as $notification) {
            if(Carbon::parse($notification->created_at)->format('Y-m-d') == $input['date']){
            $data[$i]['id'] = $notification->id;
            $data[$i]['title'] = $notification->title;
            $data[$i]['body'] = $notification->body;
            $data[$i]['client_id'] = $notification->client_id;
            $data[$i]['status'] = $notification->status;
            $i++;
        }
        }

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get notifications!'
            ],
            $this->successStatus
        );
    }



}
