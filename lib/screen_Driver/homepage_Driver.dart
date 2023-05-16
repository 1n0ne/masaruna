// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_local_variable, file_names, avoid_print

import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/screen/popup.dart';
import 'package:masaruna/screen/workoff.dart';
import 'package:masaruna/screen_Driver/notification_Driver.dart';

import '../model/user_model.dart';
import 'driver_delivery_status.dart';

class HomePageWidget_Driver extends StatefulWidget {
  const HomePageWidget_Driver({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageWidget_Driver> createState() => _HomePageWidget_DriverState();
}

class _HomePageWidget_DriverState extends State<HomePageWidget_Driver> {
  final Control _control = Control();
  final User_Control _user_control = User_Control();

  String myToken = '';
  gettoken() async {
    await FirebaseMessaging.instance.getToken().then((value) => setState(() {
          myToken = value!.toString();
        }));
    _control.update_fcm(myToken.toString());
    await get_profile();
  }

  var latitude = 0.0;
  var longitude = 0.0;
  late Position cl;

  Future getPostion() async {
    bool services;
    services = await Geolocator.isLocationServiceEnabled();

    LocationPermission per;
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per != LocationPermission.denied) {
      getLatAndLong();
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);

    setState(() {
      latitude = cl.latitude;
      longitude = cl.longitude;
      update_location(latitude, longitude);
      isloading = false;
    });
  }

  update_location(lat, long) {
    Future.delayed(const Duration(seconds: 60), () {
      _control.update_location(lat, long);
      print('update_location');
      update_location(lat, long);
    });
  }

  bool isloading = true;
  user_model? user;

  get_profile() async {
    await _user_control.profile().then((value) => setState(() {
          user = value!;
        }));
  }

  DatePik() async {
    DateTime? pickeddate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
  }

  @override
  void initState() {
    gettoken();
    getPostion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 80,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const DriverNotificationPage())));
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 55,
                color: goodcolor,
              )),
        ],
        leading: Transform.rotate(
          angle: 90 * pi / 60,
          child: const PopupMenuOption(),
        ),
      ),
      body: isloading
          ? const SizedBox(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: size.width,
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: 120,
                        width: size.width * 0.8,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Kbackground,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "مرحبا ${user?.name.toString()}"
                                "\n"
                                " ${DateTime.now().hour > 11 ? "مساء الخير" : "صباح الخير"}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: goodcolor, fontSize: 18),
                              ),
                            ),
                            Image.asset(
                              'assets/images/Hello.png',
                              height: 120,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                width: size.width * 0.37,
                                height: 70,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Kbackground),
                                child: const Center(
                                    child: Text(
                                  "حالة التوصيل",
                                  style: TextStyle(
                                      color: goodcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const DriverDeliveryStatus())));
                              },
                            ),
                            InkWell(
                              child: Container(
                                width: size.width * 0.37,
                                height: 70,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Kbackground),
                                child: const Center(
                                    child: Text(
                                  "إعتذار عن الدوام ",
                                  style: TextStyle(
                                      color: goodcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return const WorkOff();
                                      });
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
