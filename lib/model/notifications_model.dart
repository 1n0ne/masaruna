// ignore_for_file: non_constant_identifier_names, camel_case_types

class notifications_model {
  final dynamic title;
  final dynamic body;
  final dynamic client_id;
  final dynamic status;

  notifications_model({
    required this.title,
    required this.body,
    required this.client_id,
    required this.status,
  });

  factory notifications_model.fromJson(Map<String, dynamic> json) {
    return notifications_model(
      title: json['title'] as dynamic,
      body: json['body'] as dynamic,
      client_id: json['client_id'] as dynamic,
      status: json['status'] as dynamic,
    );
  }
}
