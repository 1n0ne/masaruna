// ignore_for_file: camel_case_types

class day_model {
  final dynamic id;
  final dynamic name;

  day_model({
    required this.id,
    required this.name,
  });

  factory day_model.fromJson(Map<String, dynamic> json) {
    return day_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
