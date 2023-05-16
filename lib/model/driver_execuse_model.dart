// ignore_for_file: non_constant_identifier_names, camel_case_types

class driver_execuse_model {
  final dynamic student_id;
  final dynamic student_name;
  final dynamic student_long;
  final dynamic student_lat;

  driver_execuse_model({
    required this.student_id,
    required this.student_name,
    required this.student_long,
    required this.student_lat,
  });

  factory driver_execuse_model.fromJson(Map<String, dynamic> json) {
    return driver_execuse_model(
      student_id: json['student_id'] as dynamic,
      student_name: json['student_name'] as dynamic,
      student_long: json['student_long'] as dynamic,
      student_lat: json['student_lat'] as dynamic,
    );
  }
}
