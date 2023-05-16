// ignore_for_file: non_constant_identifier_names, file_names, avoid_print

import 'dart:math';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/screen/popup.dart';
import 'package:masaruna/screen_Driver/dashboard_Driver.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';

import '../model/notifications_model.dart';

class DriverNotificationPage extends StatefulWidget {
  const DriverNotificationPage({super.key});

  @override
  State<DriverNotificationPage> createState() => _DriverNotificationPageState();
}

class _DriverNotificationPageState extends State<DriverNotificationPage> {
  final Control _control = Control();
  List<notifications_model> Lnotifications = [];
  List<notifications_model> L_Date_notifications = [];
  get_client_notifications() {
    _control.get_client_notifications().then((value) {
      setState(() {
        Lnotifications = value!;
      });
    });
  }

  get_client_date_notifications() {
    _control.get_client_date_notifications().then((value) {
      setState(() {
        Lnotifications = value!;
      });
    });
  }

  int i = 0;
  bool all = true;

  @override
  void initState() {
    get_client_notifications();
    get_client_date_notifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        builder: ((context) => const dashboard_Driver())));
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 55,
                color: goodcolor,
              )),
        ],
        leading: Transform.rotate(
          angle: 90 * pi / 60,
          child: const PopupMenuOption(),
        ),
      ),
      body: SizedBox(
          width: size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ToggleSwitch(
                minWidth: 150.0,
                initialLabelIndex: i,
                fontSize: 20,
                borderWidth: 2,
                cornerRadius: 10.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.white,
                inactiveFgColor: goodcolor,
                borderColor: const [goodcolor3],
                totalSwitches: 2,
                labels: const ['الكل', 'اليوم'],
                activeBgColors: const [
                  [goodcolor3],
                  [goodcolor3]
                ],
                onToggle: (index) {
                  setState(() {
                    i == 0 ? i = 1 : i = 0;
                    all = !all;
                  });

                  print('switched to: $index');
                },
              ),
              all
                  ? Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ListView.builder(
                          itemCount: Lnotifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Kbackground,
                              ),
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Lnotifications[index].status == 5
                                          ? const Icon(
                                              Icons.remove_circle,
                                              size: 30,
                                            )
                                          : Lnotifications[index].status == 1
                                              ? const Icon(
                                                  Icons.person_add_alt,
                                                  size: 30,
                                                )
                                              : Lnotifications[index].status ==
                                                      2
                                                  ? const Icon(
                                                      Icons.money_sharp,
                                                      size: 30,
                                                    )
                                                  : const Icon(
                                                      Icons.check,
                                                      size: 30,
                                                    ),
                                      Expanded(
                                          child: Text(
                                        Lnotifications[index].body.toString(),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 1, child: Divider())
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ListView.builder(
                          itemCount: L_Date_notifications.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Kbackground,
                              ),
                              height: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      L_Date_notifications[index].status == 5
                                          ? const Icon(
                                              Icons.remove_circle,
                                              size: 30,
                                            )
                                          : L_Date_notifications[index]
                                                      .status ==
                                                  1
                                              ? const Icon(
                                                  Icons.person_add_alt,
                                                  size: 30,
                                                )
                                              : L_Date_notifications[index]
                                                          .status ==
                                                      2
                                                  ? const Icon(
                                                      Icons.money_sharp,
                                                      size: 30,
                                                    )
                                                  : const Icon(
                                                      Icons.check,
                                                      size: 30,
                                                    ),
                                      Expanded(
                                          child: Text(
                                        L_Date_notifications[index]
                                            .body
                                            .toString(),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 1, child: Divider())
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
            ],
          )),
    );
  }
}
