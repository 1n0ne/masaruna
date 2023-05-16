<?php

namespace App\Http\Controllers\Api;

use App\Advertisment;
use App\City;
use App\Client;
use App\ClientDay;
use App\Contact;
use App\Day;
use App\Driver;
use App\DriverRate;
use App\DriverSubscribe;
use App\Execus;
use App\Helpers\StaticsData;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;
use App\Notification;
use App\Rating;
use App\Street;
use App\Student;
use App\StudentRate;
use App\Subscribe;
use App\University;
use Illuminate\Http\Request;
use Validator;
use App\User;
use Exception;
use Hamcrest\Core\IsNull;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{

    public $successStatus = 200;
    //  client انشاء حساب



    public function register_student(Request $request)
    {
        $rules = [
            'email' => 'required|unique:clients',
            'phone' => 'required|numeric|min:10',
            'password' => 'required',
            'type_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $student = Client::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }





        $data['id'] = $student->id;
        $data['type_id'] = $student->type_id;
        $data['email'] = $student->email;
        $data['phone'] = $student->phone;
        $data['password'] = $student->password;
        $code = 000000;
        $student->code = $code;
        $student->save();
        $data['code'] = $student->code;
        $type_id = $student->type_id;
        if ($type_id == 1) {
            $type = "طالب";
        }
        if ($type_id == 2) {
            $type = "سائق باص";
        }
        if ($type_id == 3) {
            $type = "ولي أمر";
        }
        $data['type'] = $type;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created student account!'
            ],
            $this->successStatus
        );
    }

    // انشاء حساب سائق
    public function register_driver(Request $request)
    {
        $rules = [
            'email' => 'required',
            'phone' => 'required|numeric|min:10',
            'password' => 'required',
            'type_id' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $driver = Client::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }





        $data['id'] = $driver->id;
        $data['email'] = $driver->email;
        $data['phone'] = $driver->phone;
        $data['password'] = $driver->password;
        $code = 000000;
        //random_int(1000, 9999);
        $driver->code = $code;
        $driver->save();
        $data['code'] = $driver->code;

        $data['type_id'] = $driver->type_id;
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
        $data['type'] = $type;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created driver account!'
            ],
            $this->successStatus
        );
    }
    // اكمال انشاء حساب طالب
    public function register_student_complete(Request $request)
    {
        $rules = [
            'id' => 'required|exists:clients',
            'name' => 'required|max:50',
            'gender' => 'required',
            // 'city' => 'required',
            // 'street' => 'required',
            'home_number' => 'required',
            'lat' => 'required',
            'long' => 'required',
            // 'university' => 'required',
            'start_time' => 'required',
            'end_time' => 'required',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            // $student = Client::where('id', $input['id'])->update($input);
            $student = Client::where('id', $input['id'])->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $city = City::WHERE('name', $input['city'])->first();
        $city_id = $city->id;
        $street = Street::WHERE('name', $input['street'])->first();
        $street_id = $street->id;
        $university = University::WHERE('name', $input['university'])->first();
        $university_id = $university->id;
        $student->city_id = $city_id;
        $student->street_id = $street_id;
        $student->university_id = $university_id;
        $student->name = $input['name'];
        $student->lat =  $input['lat'];
        $student->long =  $input['long'];
        $student->home_number =  $input['home_number'];
        $student->start_time =  $input['start_time'];
        $student->end_time =  $input['end_time'];
        $student->save();
        $student = Client::where('id', $input['id'])->first();
        $data['id'] = $student->id;
        $data['name'] = $student->name;
        $data['email'] = $student->email;
        $data['phone'] = $student->phone;
        $data['password'] = $student->password;
        $data['gender'] = $student->gender;
        $data['city_id'] = $student->city_id;
        $data['street_id'] = $student->street_id;
        $data['home_number'] = $student->home_number;
        $data['lat'] = $student->lat;
        $data['long'] = $student->long;
        if ($request->hasFile('image')) {
            $x = Storage::disk('public')->put('', $request->image);
            $data['image'] =  $x;
            $student['image'] =  $x;
            $student->save();
            $data['image'] = $student->image;
        }

        $data['university_id'] = $student->university_id;
        $data['code'] = $student->code;
        $data['start_time'] = $student->start_time;
        $data['end_time'] = $student->end_time;
        $data['type_id'] = $student->type_id;
        $type_id = $student->type_id;
        if ($type_id == 1) {
            $type = "طالب";
        }
        if ($type_id == 2) {
            $type = "سائق باص";
        }
        if ($type_id == 3) {
            $type = "ولي أمر";
        }
        $data['type'] = $type;

        $data['device_token'] = $student->device_token;




        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created student account!'
            ],
            $this->successStatus
        );
    }







    // اكمال انشاء حساب سائق

    public function register_driver_complete(Request $request)
    {
        $rules = [
            'id' => 'required|exists:clients',
            'name' => 'required|max:50',
            'gender' => 'required',
            'car' => 'required',
            'seats' => 'required',
            'car_number' => 'required',
            'range' => 'required',
            'time' => 'required',
            'cost' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            // $driver = Client::where('id', $input['id'])->update($input);
            $driver = Client::where('id', $input['id'])->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }





        $data['id'] = $driver->id;
        $city = City::WHERE('name', $input['city'])->first();
        $city_id = $city->id;
        $street = Street::WHERE('name', $input['street'])->first();
        $street_id = $street->id;
        $university = University::WHERE('name', $input['university'])->first();
        $university_id = $university->id;
        $driver->city_id = $city_id;
        $driver->street_id = $street_id;
        $driver->university_id = $university_id;
        $driver->save();


        $driver->name = $input['name'];
        $driver->gender = $input['gender'];
        $driver->car =  $input['car'];
        $driver->seats =  $input['seats'];
        $driver->car_number =  $input['car_number'];
        $driver->range =  $input['range'];
        $driver->time =  $input['time'];
        $driver->cost =  $input['cost'];

        $driver->save();















        $driver = Client::where('id', $input['id'])->first();

        $data['name'] = $driver->name;
        $data['email'] = $driver->email;
        $data['phone'] = $driver->phone;
        $data['password'] = $driver->password;
        $data['gender'] = $driver->gender;
        $data['city_id'] = $driver->city_id;
        $city = City::WHERE('id', $data['city_id'])->first();
        $data['city_name'] = $city->name;
        $data['street_id'] = $driver->street_id;
        $street = Street::WHERE('id', $data['street_id'])->first();
        $data['street_name'] = $street->name;
        $data['university_id'] = $driver->university_id;
        $university = University::WHERE('id', $data['university_id'])->first();
        $data['university_name'] = $university->name;
        $data['car'] = $driver->car;
        $data['seats'] = $driver->seats;
        $data['car_number'] = $driver->car_number;
        $data['time'] = $driver->time;
        $data['range'] = $driver->range;
        $data['cost'] = $driver->cost;
        $data['code'] = $driver->code;
        $data['device_token'] = $driver->device_token;


        if ($request->hasFile('image')) {
            $x = Storage::disk('public')->put('', $request->image);
            $data['image'] =  $x;
            $driver['image'] =  $x;
            $driver->save();
            $data['image'] = $driver->image;
        }

        $data['type_id'] = $driver->type_id;
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
        $data['type'] = $type;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created driver account!'
            ],
            $this->successStatus
        );
    }


    // update profile
    public function update_profile(Request $request)
    {
        $rules = [
            'id' => 'required|exists:clients',
            // 'name' => 'required|max:50',
            // 'gender' => 'required',
            // 'home_number' => 'required',
            // 'lat' => 'required',
            // 'long' => 'required',
            // 'start_time' => 'required',
            // 'end_time' => 'required',
            // 'email' => 'required',
            // 'phone' => 'required|numeric|min:10',
            // 'password' => 'required',
            // 'type_id' => 'required',
            // 'car' => 'required',
            // 'seats' => 'required',
            // 'car_number' => 'required',
            // 'range' => 'required',
            // 'time' => 'required',
            // 'cost' => 'required',
            // 'city' => 'required',
            // 'street' => 'required',
            // 'university' => 'required',

        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

      
      
        $client = Client::where('id', $input['id'])->first();
        if($client){
      
      
        $data['id'] = $client->id;
             if($request->has('city')){
        $city = City::WHERE('name', $input['city'])->first();
        $city_id = $city->id;
         $client->city_id = $city_id;}
        
        
               if($request->has('street')){
        $street = Street::WHERE('name', $input['street'])->first();
        $street_id = $street->id;
             
        $client->street_id = $street_id; }
        
           if($request->has('university')){
        $university = University::WHERE('name', $input['university'])->first();
        $university_id = $university->id;
        
        

        $client->university_id = $university_id;
           }

     if($request->has('phone'))
        $client->phone = $input['phone'];    

     
     if($request->has('name'))
        $client->name = $input['name'];     
     if($request->has('gender'))
        $client->gender = $input['gender'];
             
     if($request->has('car'))
        $client->car =  $input['car'];
             
     if($request->has('seats'))
        $client->seats =  $input['seats'];
             
     if($request->has('car_number'))
        $client->car_number =  $input['car_number'];
             
     if($request->has('range'))
        $client->range =  $input['range'];
             
     if($request->has('time'))
        $client->time =  $input['time'];
             
     if($request->has('cost'))
        $client->cost =  $input['cost'];
             
    
             
     if($request->has('lat'))
        $client->lat =  $input['lat'];
             
     if($request->has('long'))
        $client->long =  $input['long'];
             
     if($request->has('home_number'))
        $client->home_number =  $input['home_number'];
             
     if($request->has('start_time'))
        $client->start_time =  $input['start_time'];
             
     if($request->has('end_time'))
        $client->end_time =  $input['end_time'];

        $client->save();
        }
     //   $client = Client::where('id', $input['id'])->first();




        // $data['id'] = $client->id;
        // $data['name'] = $client->name;
        // $data['email'] = $client->email;
        // $data['phone'] = $client->phone;
        // $data['password'] = $client->password;
        // $data['gender'] = $client->gender;
        // $data['city_id'] = $client->city_id;
        // $data['street_id'] = $client->street_id;
        // $data['home_number'] = $client->home_number;
        // $data['lat'] = $client->lat;
        // $data['long'] = $client->long;
        if ($request->hasFile('image')) {
            $x = Storage::disk('public')->put('', $request->image);
          
            $client['image'] =  $x;
        
        }

        // $data['university_id'] = $client->university_id;
        // $data['code'] = $client->code;
        // $data['start_time'] = $client->start_time;
        // $data['end_time'] = $client->end_time;
        // $data['type_id'] = $client->type_id;
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
       $client->type = $type;

        // $data['car'] = $client->car;
        // $data['seats'] = $client->seats;
        // $data['car_number'] = $client->car_number;
        // $data['time'] = $client->time;
        // $data['range'] = $client->range;
        // $data['cost'] = $client->cost;
        // $data['code'] = $client->code;
        // $data['device_token'] = $client->device_token;


        return response()->json(
            [
                'status' => '1',
                'data' => $client,
                'message' => 'Successfully updated client account!'
            ],
            $this->successStatus
        );
    }

// update driver location
public function update_location(Request $request)
{
    $rules = [
        'id' => 'required|exists:clients',
        'lat' => 'required',
        'long' => 'required'    ];
    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
    }

    $input = $request->all();

    try {
        $client = Client::where('id', $input['id'])->update($input);
        $client = Client::where('id', $input['id'])->first();
    } catch (Exception $e) {
        return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
    }
    $client = Client::where('id', $input['id'])->first();




    $data['id'] = $client->id;
    $data['name'] = $client->name;
    $data['email'] = $client->email;
    $data['phone'] = $client->phone;
    $data['password'] = $client->password;
    $data['gender'] = $client->gender;
    $data['city_id'] = $client->city_id;
    $data['street_id'] = $client->street_id;
    $data['home_number'] = $client->home_number;
    $data['lat'] = $client->lat;
    $data['long'] = $client->long;
    if ($request->hasFile('image')) {
        $x = Storage::disk('public')->put('', $request->image);
        $data['image'] =  $x;
        $client['image'] =  $x;
        $client->save();
        $data['image'] = $client->image;
    }

    $data['university_id'] = $client->university_id;
    $data['code'] = $client->code;
    $data['start_time'] = $client->start_time;
    $data['end_time'] = $client->end_time;
    $data['type_id'] = $client->type_id;
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
    $data['type'] = $type;

    $data['car'] = $client->car;
    $data['seats'] = $client->seats;
    $data['car_number'] = $client->car_number;
    $data['time'] = $client->time;
    $data['range'] = $client->range;
    $data['cost'] = $client->cost;
    $data['code'] = $client->code;
    $data['device_token'] = $client->device_token;


    return response()->json(
        [
            'status' => '1',
            'data' => $data,
            'message' => 'Successfully updated client account!'
        ],
        $this->successStatus
    );
}



    //  client تسجيل دخول 
    public function login_client(Request $request)
    {
        $rules = [
            'email' => 'required|exists:clients',
            'password' => 'required|min:8',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }
        $countclient = Client::Where('email', $request['email'])
            ->where('password', $request['password'])
            ->count();

        if ($countclient != 0) {
            $client = Client::Where('email', $request['email'])
                ->where('password', $request['password'])
                ->get()->first();

            $data['id'] = $client->id;
            $data['name'] = $client->name;
            $data['email'] = $client->email;
            $data['phone'] = $client->phone;
            $data['password'] = $client->password;
            $data['gender'] = $client->gender;
            $data['home_number'] = $client->home_number;
            $data['lat'] = $client->lat;
            $data['long'] = $client->long;
            $data['image'] = $client->image;
            $data['start_time'] = $client->start_time;
            $data['end_time'] = $client->end_time;
            $data['type_id'] = $client->type_id;
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

            $data['type'] = $type;

            $data['city_id'] = $client->city_id;
            $city = City::WHERE('id', $data['city_id'])->first();
            $data['city_name'] = $city->name;
            $data['street_id'] = $client->street_id;
            $street = Street::WHERE('id', $data['street_id'])->first();
            $data['street_name'] = $street->name;
            $data['university_id'] = $client->university_id;
            $university = University::WHERE('id', $data['university_id'])->first();
            $data['university_name'] = $university->name;
            $data['car'] = $client->car;
            $data['seats'] = $client->seats;
            $data['car_number'] = $client->car_number;
            $data['time'] = $client->time;
            $data['range'] = $client->range;
            $data['cost'] = $client->cost;
            $data['code'] = $client->code;
            $data['device_token'] = $client->device_token;


            return response()->json(
                [
                    'status' => '1',
                    'data' => $data,
                    'message' => 'Successfully login client!'
                ],
                $this->successStatus
            );
        } else {
            return response()->json(['data' => 'check your email and password', 'status' => '-1'], $this->successStatus);
        }
    }

    //  client جلب بيانات 
    public function get_profile_client(Request $request)
    {
        $rules = [
            'id' => 'required|exists:clients',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }
        $countclient = Client::Where('id', $request['id'])
            ->count();



        if ($countclient != 0) {
            $client = Client::Where('id', $request['id'])
                ->get()->first();
            $data['id'] = $client->id;
            $data['name'] = $client->name;
            $data['email'] = $client->email;
            $data['phone'] = $client->phone;
            $data['password'] = $client->password;
            $data['gender'] = $client->gender;
            $data['home_number'] = $client->home_number;
            $data['lat'] = $client->lat;
            $data['long'] = $client->long;
            $data['image'] = $client->image;
            $data['start_time'] = $client->start_time;
            $data['end_time'] = $client->end_time;
            $data['type_id'] = $client->type_id;
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

            $data['type'] = $type;
            $data['city_id'] = $client->city_id;
            $city = City::WHERE('id', $data['city_id'])->first();
            $data['city_name'] = $city->name;
            $data['street_id'] = $client->street_id;
            $street = Street::WHERE('id', $data['street_id'])->first();
            $data['street_name'] = $street->name;
            $data['university_id'] = $client->university_id;
            $university = University::WHERE('id', $data['university_id'])->first();
            $data['university_name'] = $university->name;
            $data['car'] = $client->car;
            $data['seats'] = $client->seats;
            $data['car_number'] = $client->car_number;
            $data['time'] = $client->time;
            $data['range'] = $client->range;
            $data['cost'] = $client->cost;
            $data['code'] = $client->code;
            $data['image'] = $client->image;
            $data['device_token'] = $client->device_token;



            return response()->json(
                [
                    'status' => '1',
                    'data' => $data,
                    'message' => 'Successfully get profile client!'
                ],
                $this->successStatus
            );
        } else {
            return response()->json(['data' => 'check your id', 'status' => '-1'], $this->successStatus);
        }
    }



    // get drivers


    public function get_drivers(Request $request)
    {

        try {
            $drivers = Client::Where('type_id', 2)->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($drivers as $driver) {
            $driver_city_id = $driver->city_id;
if(!is_null($driver_city_id)){
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
            $i++;
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

    public function get_city_drivers(Request $request)
    {
        
        $rules = [
            'id' => 'required|exists:cities',
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }
   $input=$request->all();

        try {
            $drivers = Client::Where('type_id', 2)->WHERE('city_id',$input['id'])->get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $i = 0;
        $data = [];
        foreach ($drivers as $driver) {
            $driver_city_id = $driver->city_id;
if(!is_null($driver_city_id)){
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
            $i++;
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


 // get cost drivers get_rate_drivers

 public function get_cost_drivers(Request $request)
 {

    $rules = [
        'cost' => 'required'
    ];
    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
    }
$input=$request->all();
     try {
         $drivers = Client::Where('type_id', 2)->get();
     } catch (Exception $e) {
         return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
     }

     $i = 0;
     $data = [];
     foreach ($drivers as $driver) {
         $driver_city_id = $driver->city_id;
if(!is_null($driver_city_id)){
    if($driver->cost <= $input['cost']){
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
         $i++;
     }
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

 // get rate drivers

 public function get_rate_drivers(Request $request)
 {

    $rules = [
        'rate' => 'required'
    ];
    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
        return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
    }
$input=$request->all();
     try {
         $drivers = Client::Where('type_id', 2)->get();
     } catch (Exception $e) {
         return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
     }

     $i = 0;
     $data = [];
     foreach ($drivers as $driver) {
         $driver_city_id = $driver->city_id;
if(!is_null($driver_city_id)){
    $countrate = DriverRate::where('driver_id', $driver->id)->count();
    if ($countrate != 0) {
        $rates = DriverRate::where('driver_id',  $driver->id)->get();
        $j = 0;
        $sum = 0;
        foreach ($rates as $rate) {
            $sum = $sum + $rate->rate;
            $j++;
        }
        $avg = $sum / $j;
    } else {
        $avg = 0;
    }


    if( $input['rate'] <= $avg){
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
         $data[$i]['avg'] = $avg;

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
         $i++;
     }
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






    // get advertisment


    public function get_advertisment(Request $request)
    {
        try {
            $advertisment = Advertisment::latest('id')->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $data['id'] = $advertisment['id'];
        $data['title'] = $advertisment['title'];
        $data['content'] = $advertisment['content'];

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get advertisments!'
            ],
            $this->successStatus
        );
    }


    // universities استرجاع كافة الجامعات 

    public function get_universities(Request $request)
    {
        try {
            $universities = University::get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $i = 0;
        $data = [];
        foreach ($universities as $university) {
            $data[$i]['id'] = $university['id'];
            $data[$i]['name'] = $university['name'];
            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get universities!'
            ],
            $this->successStatus
        );
    }



    // cities استرجاع كافة المدن 

    public function get_cities(Request $request)
    {
        try {
            $cities = City::get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $i = 0;
        $data = [];
        foreach ($cities as $city) {
            $data[$i]['id'] = $city['id'];
            $data[$i]['name'] = $city['name'];
            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get cities!'
            ],
            $this->successStatus
        );
    }

    // streets استرجاع كافة الأحياء 

    public function get_streets(Request $request)
    {
        try {
            $streets = Street::get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $i = 0;
        $data = [];
        foreach ($streets as $street) {
            $data[$i]['id'] = $street['id'];
            $data[$i]['name'] = $street['name'];
            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get streets!'
            ],
            $this->successStatus
        );
    }

    // days استرجاع كافة الأيام 

    public function get_days(Request $request)
    {
        try {
            $days = Day::get();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $i = 0;
        $data = [];
        foreach ($days as $day) {
            $data[$i]['id'] = $day['id'];
            $data[$i]['name'] = $day['name'];
            $i++;
        }


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully get days!'
            ],
            $this->successStatus
        );
    }

    // اعذار المستخدمين
    public function add_execuse(Request $request)
    {
        $rules = [
            'date' => 'required',
            'client_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $execuse = Execus::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $data['date'] = $input['date'];
        $data['client_id'] = $input['client_id'];
        $client = Client::where('id', $data['client_id'])->first();
        $data['client_name'] = $client['name'];
        $data['type_id'] = $client['type_id'];

if($data['type_id']==1)
{
    $subscribes = Subscribe::Where('student_id', $input['client_id'])->Where('status', '=', 2)->get();
    foreach($subscribes as $subscribe)
    {
    $firebaseToken = Client::where('id','=',$subscribe['driver_id'])->whereNotNull('device_token')->pluck('device_token')->all();
    $SERVER_API_KEY = env('FCM_SERVER_KEY');

    $input = $request->all();
    $title = "ملاحظة اعتذار";
    $body = "يوجد اعتذار جديد";
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
}
}
else
{
    $subscribes = Subscribe::Where('driver_id', $input['client_id'])->Where('status', '=', 2)->get();
    foreach($subscribes as $subscribe)
    {
    $firebaseToken = Client::where('id','=',$subscribe['student_id'])->whereNotNull('device_token')->pluck('device_token')->all();
    $SERVER_API_KEY = env('FCM_SERVER_KEY');

    $input = $request->all();
    $title = "ملاحظة اعتذار";
    $body = " يوجد اعتذار جديد";
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


}
}


        // 0 انتظار
        // 1 دفع
        // 2 مشترك
        // 3 انتهى الاشتراك
        // 4 تم الرفض
        // 5 اعتذار
        $value = [];
        $value['title'] = $title;
        $value['body'] = $body;
        $value['client_id'] = $data['client_id'];
        $value['status'] = 5;


        $notification = Notification::create($value);

        $data['title'] = $notification->title;
        $data['body'] = $notification->body;
        $data['notification_id'] = $notification->id;
        $data['notification_status'] = $notification->status;

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added execuse!'
            ],
            $this->successStatus
        );
    }

    // استرجاع الاعتذارات للسائق
    public function get_driver_execuse(Request $request)
    {

        $rules = [
            'date' => 'required',
            'driver_id' => 'required'
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

        $i = 0;
        $data = [];
        foreach ($subscribes as $subscribe) {

            $execuse = Execus::Where('date', $input['date'])->Where('client_id',  $subscribe->student_id)->count();

            if ($execuse != 0) {
                $counts = Subscribe::Where('driver_id', $input['driver_id'])->Where('student_id', $subscribe->student_id)->Where('status', 2)->count();
                if ($counts != 0) {

                    // $data[$i]['id'] = $subscribe->id;
                    $data[$i]['student_id'] = $subscribe->student_id;
                    $student = Client::WHERE('id', $subscribe->student_id)->get()->first();
                    $data[$i]['student_name'] = $student->name;
                    $data[$i]['student_lat'] = $student->lat;
                    $data[$i]['student_long'] = $student->long;
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
                    $i++;
                }
            }
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



    // تواصل معنا

    public function contact_us(Request $request)
    {
        $rules = [
            'name' => 'required',
            'email' => 'required',
            'topic' => 'required',
            'description' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $contact = Contact::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $data['id'] = $contact->id;
        $data['email'] = $contact->email;
        $data['name'] = $contact->name;
        $data['topic'] = $contact->topic;
        $data['description'] = $contact->description;

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created contact!'
            ],
            $this->successStatus
        );
    }




    // اضافة تقييم
    public function add_rating(Request $request)
    {
        $rules = [
            'client_id' => 'required',
            'rate' => 'required',
            'suggestion' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $rating = Rating::create($input);
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $data['id'] = $rating->id;
        $data['rate'] = $rating->rate;
        $data['suggestion'] = $rating->suggestion;
        $data['client_id'] = $rating->client_id;
        $client = Client::where('id', $data['client_id'])->first();
        $data['client_name'] = $client['name'];

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully created rating!'
            ],
            $this->successStatus
        );
    }




    // تحديث كلمة المرور
    public function update_password(Request $request)
    {
        $rules = [
            'id' => 'required',
            'password' => 'required',
            'newpassword' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $client = Client::WHERE('id', $request['id'])->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $password = $client['password'];
        if ($password == $input['password']) {
            // $client = Client::WHERE('id',$request['id'])->update($input);

            $client = Client::WHERE('id', $request['id'])->first();
            $client['password'] =  $request['newpassword'];
            $client->save();
            $client = Client::WHERE('id', $request['id'])->first();
            $data['client_id'] = $client['id'];
            $data['password'] = $client['password'];
            return response()->json(
                [
                    'status' => '1',
                    'data' => $data,
                    'message' => 'Successfully updated password!'
                ],
                $this->successStatus
            );
        } else {
            return response()->json(
                [
                    'status' => '-1',
                    'data' => '',
                    'message' => 'failed updated password!'
                ],
                $this->successStatus
            );
        }
    }



    // اضافة ايام
    public function add_days(Request $request)
    {
        $rules = [
            'client_id' => 'required',
            'day_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $days_conunt = ClientDay::WHERE('client_id', $input['client_id'])->WHERE('day_id', $input['day_id'])->count();
            if ($days_conunt == 0) {
                $days = ClientDay::create($input);
            } else {
                $days =  ClientDay::WHERE('client_id', $input['client_id'])->WHERE('day_id', $input['day_id'])->get()->first();
            }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $data['id'] = $days->id;
        $data['client_id'] = $days->client_id;
        $data['day_id'] = $days->day_id;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully added to your days!'
            ],
            $this->successStatus
        );
    }

    // حذف يوم
    public function delete_day(Request $request)
    {
        $rules = [
            'client_id' => 'required',
            'day_id' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $days_conunt = ClientDay::WHERE('client_id', $input['client_id'])->WHERE('day_id', $input['day_id'])->count();
            if ($days_conunt != 0) {
                $days = ClientDay::WHERE('client_id', $input['client_id'])->WHERE('day_id', $input['day_id'])->delete();
            }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $data['id'] = $days;


        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully deleted your days!'
            ],
            $this->successStatus
        );
    }

    // استرجاع ايام المستخدم
    public function get_my_days(Request $request)
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
            $days_conunt = ClientDay::WHERE('client_id', $input['client_id'])->count();
            if ($days_conunt != 0) {
                $client_days = ClientDay::WHERE('client_id', $input['client_id'])->get();
            }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        $data = [];
        $i = 0;
        if ($days_conunt != 0) {

            foreach ($client_days as $day) {
                $d_id = $day['day_id'];
                $d = Day::where('id', $d_id)->get()->first();
                $data[$i]['id'] = $d['id'];
                $data[$i]['name'] = $d['name'];
                $i++;
            }
        }

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully returned days!'
            ],
            $this->successStatus
        );
    }



    // نسيان كلمة المرور
    public function forget_password(Request $request)
    {
        $rules = [
            'email' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $count = Client::WHERE('email', $request['email'])->count();
            if($count !=0){
            $client = Client::WHERE('email', $request['email'])->first();
        }
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }

        if($count !=0){

        $client = Client::WHERE('email', $request['email'])->first();
        $password = $client->password;
        $email = $client->email;
        $em_data = [
            'password' => $password,
            'email' => $email
        ];
        try{
        StaticsData::sendMail($email, view('emails.check', $em_data)->render(), ' email from customer');
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }
        $data = [];
        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully send password!'
            ],
            $this->successStatus
        );
    } 

    else
    {
        return response()->json(['error' => "error", 'status' => '-1'], $this->successStatus);
    }

    }
    




    public function update_fcm(Request $request)
    {
        $rules = [
            'id' => 'required',
            'device_token' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors(), 'status' => '-1'], $this->successStatus);
        }

        $input = $request->all();

        try {
            $client = Client::WHERE('id', $input['id'])->update($input);
            $client = Client::WHERE('id', $input['id'])->get()->first();
        } catch (Exception $e) {
            return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
        }



        $data['id'] = $client->id;
        $data['device_token'] = $client->device_token;

        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully updated fcm !'
            ],
            $this->successStatus
        );
    }

    public function sendNotification(Request $request)
    {
        $firebaseToken = Client::whereNotNull('device_token')->pluck('device_token')->all();

        $SERVER_API_KEY = env('FCM_SERVER_KEY');

        $input = $request->all();
        $title = "title";
        $body = "body";
        $data = [
            "registration_ids" => $firebaseToken,
            "notification" => [
                "title" => $title,
                "body" => $body,
            ]
        ];
        $dataString = json_encode($data);

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
        $date = [];
        return response()->json(
            [
                'status' => '1',
                'data' => $data,
                'message' => 'Successfully updated fcm !'
            ],
            $this->successStatus
        );
    }












 // حذف يوم
 public function delete_client(Request $request)
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
             $d = ClientDay::WHERE('client_id', $input['client_id'])->delete();
             $d = DriverRate::WHERE('student_id', $input['client_id'])->delete();
             $d = DriverRate::WHERE('driver_id', $input['client_id'])->delete();
             $d = DriverSubscribe::WHERE('student_id', $input['client_id'])->delete();
             $d = DriverSubscribe::WHERE('driver_id', $input['client_id'])->delete();
             $d = Execus::WHERE('client_id', $input['client_id'])->delete();
             $d = Notification::WHERE('client_id', $input['client_id'])->delete();
             $d = Rating::WHERE('client_id', $input['client_id'])->delete();
             $d = StudentRate::WHERE('student_id', $input['client_id'])->delete();
             $d = StudentRate::WHERE('driver_id', $input['client_id'])->delete();
             $d = Subscribe::WHERE('student_id', $input['client_id'])->delete();
             $d = Subscribe::WHERE('driver_id', $input['client_id'])->delete();
             $d = Client::WHERE('id', $input['client_id'])->delete();

     } catch (Exception $e) {
         return response()->json(['error' => $e, 'status' => '-1'], $this->successStatus);
     }

     $data['d'] = $d;


     return response()->json(
         [
             'status' => '1',
             'data' => $data,
             'message' => 'Successfully deleted your account!'
         ],
         $this->successStatus
     );
 }

















}
