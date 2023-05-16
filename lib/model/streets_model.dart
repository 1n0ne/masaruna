// ignore_for_file: camel_case_types, implementation_imports

import 'package:searchfield/src/searchfield.dart';

class streets_model {
  final dynamic id;
  final dynamic name;

  streets_model({
    required this.id,
    required this.name,
  });

  factory streets_model.fromJson(Map<String, dynamic> json) {
    return streets_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
    );
  }

  map(SearchFieldListItem<Object> Function(dynamic e) param0) {}
}
