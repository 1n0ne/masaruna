// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/screen/dashboard.dart';
import 'package:masaruna/screen/popup.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';

import '../model/notifications_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Control _control = Control();
  int i = 0;
  bool all = true;
  List<notifications_model> Lnotifications = [];
  List<notifications_model> Lnotifications_date = [];
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
        Lnotifications_date = value!;
      });
    });
  }

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
                        builder: ((context) => const dashboard())));
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 50,
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
                onToggle: (inedx) {
                  setState(() {
                    i == 0 ? i = 1 : i = 0;
                    all = !all;
                  });
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
                  : newMethod(context)
            ],
          )),
    );
  }

  Expanded newMethod(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: ListView.builder(
          itemCount: Lnotifications_date.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Kbackground,
              ),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Lnotifications_date[index].status == 5
                          ? const Icon(
                              Icons.remove_circle,
                              size: 30,
                            )
                          : Lnotifications_date[index].status == 1
                              ? const Icon(
                                  Icons.person_add_alt,
                                  size: 30,
                                )
                              : Lnotifications_date[index].status == 2
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
                        Lnotifications_date[index].body.toString(),
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
    );
  }
}
