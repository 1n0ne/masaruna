// ignore_for_file: camel_case_types

class universities_model {
  final dynamic id;
  final dynamic name;

  universities_model({
    required this.id,
    required this.name,
  });

  factory universities_model.fromJson(Map<String, dynamic> json) {
    return universities_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
