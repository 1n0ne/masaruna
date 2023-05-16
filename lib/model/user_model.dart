// ignore_for_file: non_constant_identifier_names, camel_case_types

class user_model {
  final dynamic id;
  final dynamic name;
  final dynamic email;
  final dynamic phone;
  final dynamic gender;
  final dynamic home_number;
  final dynamic lat;
  final dynamic long;
  final dynamic start_time;
  final dynamic end_time;
  final dynamic city_name;
  final dynamic street_name;
  final dynamic university_name;
  final dynamic cost;
  final dynamic range;
  final dynamic car_number;
  final dynamic seats;
  final dynamic car;
  final dynamic time;
  final dynamic image;
  final dynamic password;
  final dynamic type_id;

  user_model({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.home_number,
    required this.lat,
    required this.long,
    required this.start_time,
    required this.end_time,
    required this.city_name,
    required this.street_name,
    required this.university_name,
    required this.cost,
    required this.range,
    required this.car_number,
    required this.seats,
    required this.car,
    required this.time,
    required this.image,
    required this.password,
    required this.type_id,
  });

  factory user_model.fromJson(Map<String, dynamic> json) {
    return user_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
      email: json['email'] as dynamic,
      phone: json['phone'] as dynamic,
      gender: json['gender'] as dynamic,
      home_number: json['home_number'] as dynamic,
      lat: json['lat'] as dynamic,
      long: json['long'] as dynamic,
      start_time: json['start_time'] as dynamic,
      end_time: json['end_time'] as dynamic,
      city_name: json['city_name'] as dynamic,
      street_name: json['street_name'] as dynamic,
      university_name: json['university_name'] as dynamic,
      cost: json['cost'] as dynamic,
      range: json['range'] as dynamic,
      car_number: json['car_number'] as dynamic,
      seats: json['seats'] as dynamic,
      car: json['car'] as dynamic,
      time: json['time'] as dynamic,
      image: json['image'] as dynamic,
      password: json['password'] as dynamic,
      type_id: json['type_id'] as dynamic,
    );
  }
}
