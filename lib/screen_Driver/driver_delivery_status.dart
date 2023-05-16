// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:intl/intl.dart' as int;
import 'package:masaruna/model/accepted_driver_subscribe_model.dart';
import 'package:masaruna/model/driver_execuse_model.dart';

import 'driver_delivery_status2.dart';

class DriverDeliveryStatus extends StatefulWidget {
  const DriverDeliveryStatus({super.key});

  @override
  State<DriverDeliveryStatus> createState() => _DriverDeliveryStatusState();
}

class _DriverDeliveryStatusState extends State<DriverDeliveryStatus> {
  final Control _control = Control();

  DateTime date = DateTime.now();
  List<driver_execuse_model> driver_execuse = [];

  List<accepted_driver_subscribe_model> accepted_driver_subscribe = [];
  bool isloading = true;
  get_accepted_driver_subscribe() {
    String dateF = int.DateFormat('yyyy-MM-dd').format(date);
    _control.get_accepted_driver_subscribe(dateF.toString()).then((value) {
      setState(() {
        accepted_driver_subscribe = value!;
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    // get_driver_execuse();
    get_accepted_driver_subscribe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("حالة التوصيل"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: isloading
          ? const SizedBox(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => goodcolor3),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DriverDeliveryStatus2(
                                              exe: driver_execuse,
                                            )));
                              },
                              child: const Text("إبدأ")))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: accepted_driver_subscribe.length,
                              itemBuilder: (context, index) {
                                return StatusCard(
                                  don: accepted_driver_subscribe[index]
                                      .state
                                      .toString(),
                                  size: size,
                                  driver_execuse:
                                      accepted_driver_subscribe[index],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}

class StatusCard extends StatelessWidget {
  StatusCard(
      {Key? key,
      required this.size,
      required this.driver_execuse,
      required this.don})
      : super(key: key);

  final Size size;
  accepted_driver_subscribe_model driver_execuse;
  String don;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: size.width * 0.9,
          height: 60,
          decoration: BoxDecoration(
              color:
                  driver_execuse.execuse == 0 ? Kbackground : Colors.red[200],
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 55,
                      color: goodcolor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      driver_execuse.student_name.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: goodcolor),
                    ),
                  ],
                ),
              ),
              driver_execuse.execuse == 0
                  ? don == "1"
                      ? const Icon(
                          Icons.check_circle_outline,
                          color: Colors.blue,
                          size: 40,
                        )
                      : FaIcon(
                          FontAwesomeIcons.mapLocationDot,
                          color: Colors.green[700],
                          size: 30,
                        )
                  : Transform.rotate(
                      angle: 90 * pi / 40,
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 40,
                        color: Colors.red,
                      ))
            ],
          ),
        ),
      ],
    );
  }
}
