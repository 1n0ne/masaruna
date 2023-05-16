// ignore_for_file: non_constant_identifier_names, camel_case_types

class accepted_driver_subscribe_model {
  final dynamic student_id;
  final dynamic student_name;
  final dynamic student_long;
  final dynamic student_lat;
  final dynamic state;
  final dynamic student_phone;
  final dynamic status;
  final dynamic execuse;

  accepted_driver_subscribe_model({
    required this.student_id,
    required this.student_name,
    required this.student_long,
    required this.student_lat,
    required this.state,
    required this.student_phone,
    required this.status,
    required this.execuse,
  });

  factory accepted_driver_subscribe_model.fromJson(Map<String, dynamic> json) {
    return accepted_driver_subscribe_model(
      student_id: json['student_id'] as dynamic,
      student_name: json['student_name'] as dynamic,
      student_long: json['student_long'] as dynamic,
      student_lat: json['student_lat'] as dynamic,
      state: json['state'] as dynamic,
      student_phone: json['student_phone'] as dynamic,
      status: json['status'] as dynamic,
      execuse: json['execuse'] as dynamic,
    );
  }
}
