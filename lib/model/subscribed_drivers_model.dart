// ignore_for_file: camel_case_types

class subscribed_drivers_model {
  final dynamic id;
  final dynamic name;
  final dynamic cost;
  final dynamic car;
  final dynamic image;
  final dynamic range;

  subscribed_drivers_model({
    required this.id,
    required this.name,
    required this.cost,
    required this.car,
    required this.image,
    required this.range,
  });

  factory subscribed_drivers_model.fromJson(Map<String, dynamic> json) {
    return subscribed_drivers_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
      cost: json['cost'] as dynamic,
      car: json['car'] as dynamic,
      image: json['image'] as dynamic,
      range: json['range'] as dynamic,
    );
  }
}
