// ignore_for_file: camel_case_types, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masaruna/constant.dart';

class Driver_Work_Off extends StatefulWidget {
  const Driver_Work_Off({
    Key? key,
  }) : super(key: key);

  @override
  State<Driver_Work_Off> createState() => _Driver_Work_OffState();
}

class _Driver_Work_OffState extends State<Driver_Work_Off> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController date0 = TextEditingController();
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 30,
          ),
          const Text(
            "الإعتذار عن يوم",
            style: TextStyle(
                color: goodcolor, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 35,
                color: goodcolor,
              )),
        ],
      ),
      content: Form(
        child: SizedBox(
          height: 550,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 550,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      ':اليوم المعتذر عنه',
                      style: TextStyle(fontSize: 20, color: goodcolor2),
                    ),
                    Expanded(
                      // width: 300,
                      // height: 300,
                      child: DatePickerDialog(
                          cancelText: "",
                          confirmText: "",
                          initialCalendarMode: DatePickerMode.day,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030)),
                    ),
                    SizedBox(
                        width: 150,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => goodcolor2),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0))),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            size: 50,
                                            color: goodcolor,
                                          )),
                                    ],
                                  ),
                                  content: SizedBox(
                                    height: 150,
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Text(
                                          'تم ارسال الاعتذار لجميع المشتركين ',
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: goodcolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text("إرسال")))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
