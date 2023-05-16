// ignore_for_file: camel_case_types

class citie_model {
  final dynamic id;
  final dynamic name;

  citie_model({
    required this.id,
    required this.name,
  });

  factory citie_model.fromJson(Map<String, dynamic> json) {
    return citie_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }
}
