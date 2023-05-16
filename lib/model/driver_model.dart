// ignore_for_file: camel_case_types, non_constant_identifier_names

class driver_model {
  final dynamic id;
  final dynamic name;
  final dynamic cost;
  final dynamic car;
  final dynamic image;
  final dynamic range;
  final dynamic status;
  final dynamic phone;
  final dynamic kilometers;
  final dynamic execuse;
  final dynamic end_date;
  final dynamic lat;
  final dynamic long;
  final dynamic state;
  final dynamic avg;

  driver_model({
    required this.id,
    required this.name,
    required this.cost,
    required this.car,
    required this.image,
    required this.range,
    required this.status,
    required this.phone,
    required this.kilometers,
    required this.execuse,
    required this.end_date,
    required this.lat,
    required this.long,
    required this.state,
    required this.avg,
  });

  factory driver_model.fromJson(Map<String, dynamic> json) {
    return driver_model(
      id: json['id'] as dynamic,
      name: json['name'] as dynamic,
      cost: json['cost'] as dynamic,
      car: json['car'] as dynamic,
      image: json['image'] as dynamic,
      range: json['range'] as dynamic,
      status: json['status'] as dynamic,
      phone: json['phone'] as dynamic,
      kilometers: json['kilometers'] as dynamic,
      execuse: json['execuse'] as dynamic,
      end_date: json['end_date'] as dynamic,
      lat: json['lat'] as dynamic,
      long: json['long'] as dynamic,
      state: json['state'] as dynamic,
      avg: json['avg'] as dynamic,
    );
  }
}
