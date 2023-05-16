// ignore_for_file: non_constant_identifier_names, avoid_print, depend_on_referenced_packages, unused_local_variable

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masaruna/model/notifications_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as int;

import 'dart:convert';

import '../Utils/URL.dart';
import '../model/accepted_driver_subscribe_model.dart';
import '../model/advertisment_model.dart';
import '../model/driver_execuse_model.dart';
import '../model/driver_model.dart';
import '../model/driver_subscribe_model.dart';
import '../screen_Driver/driver_delivery_status.dart';

// ignore: camel_case_types
class Control {
  Future add_execuse(context, String date) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final clientId = prefs.get(key);
    String myUrl = "$serverUrl/add_execuse";
    print(date);
    print(clientId);
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'client_id': clientId,
      'date': date,
    });

    if (json.decode(response.body)['status'] == "1") {
      // Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future contact_us(context, String name, String email, String topic,
      String description) async {
    String myUrl = "$serverUrl/contact_us";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'name': name,
      'email': email,
      'topic': topic,
      'description': description,
    });

    if (json.decode(response.body)['status'] == "1") {
      // Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future add_rating(context, String rate, String suggestion) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final clientId = prefs.get(key);
    String myUrl = "$serverUrl/add_rating";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'client_id': clientId,
      'rate': rate,
      'suggestion': suggestion,
    });

    print(response.body);

    if (json.decode(response.body)['status'] == "1") {
      // Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future update_password(context, String password, String newpassword) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final clientId = prefs.get(key);
    String myUrl = "$serverUrl/update_password";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'id': clientId,
      'password': password,
      'newpassword': newpassword,
    });

    if (json.decode(response.body)['status'] == "1") {
      // Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done',
        // btnOkOnPress: () {},
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        // btnOkOnPress: () {},
      ).show();
    }
  }

  Future get_advertisment() async {
    String myUrl = "$serverUrl/get_advertisment";
    http.Response response = await http.get(Uri.parse(myUrl));

    if (json.decode(response.body)['status'] == "1") {
      try {
        advertisment_model advertisment =
            advertisment_model.fromJson(jsonDecode(response.body)['data']);

        return advertisment;
      } catch (error) {
        print(error);
      }
    } else {
      print('error get advertisment');
    }
  }

  Future<List<driver_model>?> get_city_drivers() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'city_id';
    final cityId = prefs.get(key);
    String myUrl = "$serverUrl/get_city_drivers";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'id': cityId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];
      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error get advertisment');
    }
    return null;
  }

  Future<List<driver_model>?> Check_sub(driverId) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'city_id';
    final cityId = prefs.get(key);
    String myUrl = "$serverUrl/get_driver_subscribe";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'id': cityId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];
      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error get advertisment');
    }
    return null;
  }

  Future add_subscribe(context, String driverId, String endDate) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final studentId = prefs.get(key);
    String myUrl = "$serverUrl/add_subscribe";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'driver_id': driverId,
      'student_id': studentId,
      'end_date': endDate
    });

    if (json.decode(response.body)['status'] == "1") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Done!',
        // btnOkOnPress: () {},
      ).show();
    } else {
      print('error add subscribe');
    }
  }

  Future get_subscribed_drivers(context, String studentId, String date) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final studentId = prefs.get(key);
    String myUrl = "$serverUrl/get_subscribed_drivers";
    print(studentId);
    print(date);
    http.Response response = await http
        .post(Uri.parse(myUrl), body: {'student_id': studentId, 'date': date});

    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
  }

  Future<List<driver_model>?> get_student_subscribe() async {
    DateTime datee = DateTime.now();
    String dateF = int.DateFormat('yyyy-MM-dd').format(datee);

    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final studentId = prefs.get(key);
    String myUrl = "$serverUrl/get_student_subscribe";
    http.Response response = await http
        .post(Uri.parse(myUrl), body: {'student_id': "2", 'date': dateF});
    log(response.body);
    print(response.statusCode);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  Future update_fcm(String deviceToken) async {
    print('asdasdasd');
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final id = prefs.get(key);
    String myUrl = "$serverUrl/update_fcm";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'id': id,
      'device_token': deviceToken,
    });
    print(response.body);
  }

  Future<List<driver_subscribe_model>?> get_driver_subscribe() async {
    DateTime datee = DateTime.now();
    String dateF = int.DateFormat('yyyy-MM-dd').format(datee);
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    print('get_driver_subscribe');

    String myUrl = "$serverUrl/get_driver_subscribe";
    http.Response response = await http
        .post(Uri.parse(myUrl), body: {'driver_id': driverId, 'date': dateF});
    print(response.statusCode);
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];
      log(response.body.toString());
      try {
        try {
          List<driver_subscribe_model> orders = body
              .map(
                (dynamic item) => driver_subscribe_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  Future add_student_rate(
      String studentId, String rate, String subscribeId, context) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/add_student_rate";
    print(rate);
    print(studentId);
    print(subscribeId);
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'driver_id': driverId,
      'student_id': studentId,
      'rate': rate,
      'subscribe_id': subscribeId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'تم التقييم بنجاح',
        // btnOkOnPress: () {},
      ).show();
    } else {
      print('error add subscribe');
    }
  }

  Future update_subscribe(String status, String subscribeId, context) async {
    String myUrl = "$serverUrl/update_subscribe";
    print(status);
    print(subscribeId);
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'id': subscribeId,
      'status': status,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      Navigator.of(context).pop();
    } else {
      print('error add subscribe');
    }
  }

  Future<List<driver_execuse_model>?> get_driver_execuse(String date) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/get_driver_execuse";

    print('==============$driverId');

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'driver_id': driverId,
      'date': date,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<driver_execuse_model> orders = body
              .map(
                (dynamic item) => driver_execuse_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  Future<List<accepted_driver_subscribe_model>?> get_accepted_driver_subscribe(
      String date) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/get_accepted_driver_subscribe";

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'driver_id': driverId,
      'date': date,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<accepted_driver_subscribe_model> orders = body
              .map(
                (dynamic item) =>
                    accepted_driver_subscribe_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  Future<List<notifications_model>?> get_client_notifications() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/get_client_notifications";

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'client_id': driverId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<notifications_model> orders = body
              .map(
                (dynamic item) => notifications_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  Future<List<notifications_model>?> get_client_date_notifications() async {
    DateTime datee = DateTime.now();
    String dateF = int.DateFormat('yyyy-MM-dd').format(datee);
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/get_client_date_notifications";

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'client_id': driverId,
      'date': dateF,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];

      try {
        try {
          List<notifications_model> orders = body
              .map(
                (dynamic item) => notifications_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error add subscribe');
    }
    return null;
  }

  add_student_list(String date, studentId, context) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    String myUrl = "$serverUrl/add_student_list";

    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'driver_id': driverId,
      'student_id': studentId,
      'date': date,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const DriverDeliveryStatus()));
    } else {
      print('error add subscribe');
    }
  }

  Future<List<driver_model>?> get_cost_drivers(String cost) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'city_id';
    final cityId = prefs.get(key);
    print('object');
    String myUrl = "$serverUrl/get_cost_drivers";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'cost': cost,
      'city_id': cityId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];
      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error get advertisment');
    }
    return null;
  }

  Future<List<driver_model>?> get_rate_drivers(String rate) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'city_id';
    final cityId = prefs.get(key);
    print('object');
    String myUrl = "$serverUrl/get_rate_drivers";
    http.Response response = await http.post(Uri.parse(myUrl), body: {
      'rate': rate,
      'city_id': cityId,
    });
    print(response.body);
    if (json.decode(response.body)['status'] == "1") {
      List body = jsonDecode(response.body)['data'];
      try {
        try {
          List<driver_model> orders = body
              .map(
                (dynamic item) => driver_model.fromJson(item),
              )
              .toList();
          return orders;
        } catch (error) {
          print(error);

          return null;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print('error get advertisment');
    }
    return null;
  }

  Future update_location(lat, long) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'id';
    final driverId = prefs.get(key);
    print('object');

    String myUrl = "$serverUrl/update_location";
    http.Response response = await http.post(Uri.parse(myUrl),
        body: {'id': driverId, 'lat': lat.toString(), 'long': long.toString()});
    if (json.decode(response.body)['status'] == "1") {
    } else {
      print('error get advertisment');
    }
  }
}
