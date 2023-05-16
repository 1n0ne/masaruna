// ignore_for_file: camel_case_types

class advertisment_model {
  final dynamic id;
  final dynamic content;

  advertisment_model({
    required this.id,
    required this.content,
  });

  factory advertisment_model.fromJson(Map<String, dynamic> json) {
    return advertisment_model(
      id: json['id'] as dynamic,
      content: json['content'] as dynamic,
    );
  }
}
