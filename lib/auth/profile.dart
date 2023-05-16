// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/auth/edit_profile.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/model/day_model.dart';
import 'package:masaruna/model/user_model.dart';
import 'package:avatars/avatars.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final User_Control _user_control = User_Control();
  user_model? user;
  bool isloading = true;
  List<day_model>? days = [];
  get_day() {
    _user_control.get_my_days().then((value) => setState(() {
          days = value!;
        }));
  }

  get_profile() {
    _user_control.profile().then((value) => setState(() {
          user = value!;
          isloading = false;
        }));
  }

  @override
  void initState() {
    get_day();
    get_profile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب'),
        centerTitle: true,
        leading: const SizedBox(),
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Avatar(
                          placeholderColors: const [
                            Color(0xFF7f8c8e),
                          ],
                          elevation: 3,
                          shape: AvatarShape.rectangle(100, 100,
                              const BorderRadius.all(Radius.circular(100.0))),
                          backgroundColor: const Color(0xFF7f8c8e),
                          name: user!.name.toString(),
                        ),
                      ],
                    ),
                    Text(
                      user!.name.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: goodcolor,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return edit_profile(
                            personalName: user!.name.toString(),
                            user: user,
                          );
                        }));
                      },
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                            color: goodcolor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Kbackground,
                              size: 20,
                            ),
                            Text(
                              'تعديل',
                              style:
                                  TextStyle(fontSize: 18, color: Kbackground),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: goodcolor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            user!.phone.toString(),
                            style:
                                const TextStyle(color: goodcolor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            color: goodcolor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            user!.email.toString(),
                            style:
                                const TextStyle(color: goodcolor, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: goodcolor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '${user!.city_name} , ${user!.street_name}',
                            style:
                                const TextStyle(color: goodcolor, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.school_rounded,
                            color: goodcolor,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            user!.university_name.toString(),
                            style:
                                const TextStyle(color: goodcolor, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 170,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Kbackground),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: goodcolor,
                                size: 30,
                              ),

                              Expanded(
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: days!.map((e) {
                                      return Text(
                                        "${e.name}  ,  ",
                                        style: const TextStyle(
                                            fontSize: 18, color: goodcolor),
                                        textAlign: TextAlign.center,
                                      );
                                    }).toList()),
                              ),
                              // Row(
                              //     children: days!.map((e) {
                              //   var index = days!.indexOf(e);
                              //   return Container(
                              //     width: 50,
                              //     child: Text(
                              //       index > 2
                              //           ? '\n\n\n' + e.name.toString() + " , "
                              //           : e.name.toString() + " , ",
                              //       style:
                              //           TextStyle(fontSize: 18, color: goodcolor),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   );
                              // }).toList()),
                              const SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.watch_later,
                                color: goodcolor,
                                size: 30,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'الحضور',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: goodcolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          user!.start_time.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: goodcolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'الإنصراف',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: goodcolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          user!.end_time.toString(),
                                          style: const TextStyle(
                                              fontSize: 18, color: goodcolor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
