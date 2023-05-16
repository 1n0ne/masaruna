// ignore_for_file: non_constant_identifier_names, camel_case_types

class driver_subscribe_model {
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
  final dynamic status;
  final dynamic student_id;
  final dynamic end_date;
  final dynamic avg;

  driver_subscribe_model({
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
    required this.status,
    required this.student_id,
    required this.end_date,
    required this.avg,
  });

  factory driver_subscribe_model.fromJson(Map<String, dynamic> json) {
    return driver_subscribe_model(
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
      status: json['status'] as dynamic,
      student_id: json['student_id'] as dynamic,
      end_date: json['end_date'] as dynamic,
      avg: json['avg'] as dynamic,
    );
  }
}
