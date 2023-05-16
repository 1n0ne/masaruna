// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/model/user_model.dart';
import 'package:masaruna/screen/notification.dart';
import 'package:masaruna/screen/popup.dart';
import 'package:masaruna/screen/tripstatus.dart';
import 'package:masaruna/screen/workoff.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../controls/control.dart';
import '../model/advertisment_model.dart';
import '../model/driver_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final Control _control = Control();

  String myToken = '';
  gettoken() async {
    await FirebaseMessaging.instance.getToken().then((value) => setState(() {
          myToken = value!.toString();
        }));
    _control.update_fcm(myToken.toString());
  }

  DateTime userDate = DateTime.now();

  List<driver_model> Ldriver = [];
  get_student_subscribe() {
    _control.get_student_subscribe().then((value) {
      setState(() {
        Ldriver = value!;
      });

      if (userDate.isAfter(Ldriver[0].end_date ?? DateTime.now())) {
        _control.update_subscribe('3', Ldriver[0].id.toString(), context);
      }
    });
  }

  final User_Control _user_control = User_Control();
  advertisment_model? advertisment;
  bool isloading = true;

  user_model? user;

  get_profile() {
    _user_control.profile().then((value) => setState(() {
          user = value!;
          get_advertisment();
        }));
  }

  get_advertisment() {
    _control.get_advertisment().then((value) => setState(() {
          advertisment = value!;
          isloading = false;
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
    get_student_subscribe();

    gettoken();
    get_profile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    return Scaffold(
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
                        builder: ((context) => const NotificationPage())));
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
                                "مرحبا ${user!.name}"
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
                      Container(
                        width: size.width * .8,
                        height: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Kbackground,
                        ),
                        child: Column(children: [
                          const Text(
                            "إعلان",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: goodcolor,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: size.width * .7,
                            child: Text(
                              advertisment!.content.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: goodcolor, fontSize: 15),
                            ),
                          )
                        ]),
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
                                  "حالة الرحلة",
                                  style: TextStyle(
                                      color: goodcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                              onTap: () {
                                print(Ldriver.length);
                                print(Ldriver[0].status);
                                Ldriver.isNotEmpty
                                    ?

                                    //  Ldriver[0].status != 2
                                    //     ? null
                                    //     :

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return TripStatus(
                                              driver: Ldriver[0],
                                            );
                                          });
                                        })
                                    : null;
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
