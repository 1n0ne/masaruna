// ignore_for_file: depend_on_referenced_packages, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:masaruna/Utils/URL.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/model/driver_model.dart';
import 'package:intl/intl.dart' as int;

class TripStatus extends StatefulWidget {
  driver_model driver;
  TripStatus({
    required this.driver,
    Key? key,
  }) : super(key: key);

  @override
  State<TripStatus> createState() => _TripStatusState();
}

class _TripStatusState extends State<TripStatus> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 30,
          ),
          const Text(
            "حالة الرحلة",
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
      content: StatusCard(driver: widget.driver),
    );
  }
}

class StatusCard extends StatelessWidget {
  driver_model driver;

  StatusCard({
    required this.driver,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ImageUrl + driver.image.toString());
    DateTime datee = DateTime.now();
    String dateF = int.DateFormat('yyyy-MM-dd').format(datee);
    String dateT = int.DateFormat('h:mm').format(datee);
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Kbackground),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Kbackground,
            radius: 20,
            backgroundImage: NetworkImage(ImageUrl + driver.image.toString()),
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                driver.name.toString(),
                style: const TextStyle(
                    color: goodcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              driver.execuse == 1
                  ? const Text(
                      'السائق معتذر',
                      style: TextStyle(
                        fontSize: 15,
                        color: goodcolor,
                      ),
                    )
                  : driver.state == 0
                      ? const Text(
                          'لا يوجد رحلة',
                          style: TextStyle(
                            fontSize: 15,
                            color: goodcolor,
                          ),
                        )
                      : driver.state == 1
                          ? const Text(
                              'في الطريق اليك',
                              style: TextStyle(
                                fontSize: 15,
                                color: goodcolor,
                              ),
                            )
                          : const Text(
                              'تم التوصيل',
                              style: TextStyle(
                                fontSize: 15,
                                color: goodcolor,
                              ),
                            ),
              Text(
                dateF.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: goodcolor,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 2),
            width: 70,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            child: Text(
              dateT,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }
}
