// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';

import '../../../model/user_model.dart';

class Driver_Edit_Profile extends StatefulWidget {
  user_model? user;

  Driver_Edit_Profile({super.key, required this.user});

  @override
  State<Driver_Edit_Profile> createState() => _Driver_Edit_ProfileState();
}

class _Driver_Edit_ProfileState extends State<Driver_Edit_Profile> {
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  final User_Control _user_control = User_Control();
  @override
  void initState() {
    print('=====================');
    print(phoneCon);
    print('=====================');

    phoneCon.text = widget.user!.phone.toString();
    emailCon.text = widget.user!.email.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 30),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 35,
                          color: goodcolor,
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: () {
                          _user_control.update_profile_Driver(
                            context,
                            email: emailCon.toString(),
                            homeNumber: phoneCon.text.toString(),
                            phone: phoneCon.text.toString(),
                            // widget.user!.name.toString(),
                            // widget.user!.gender.toString(),
                            // widget.user!.home_number.toString(),
                            // widget.user!.lat.toString(),
                            // widget.user!.long.toString(),
                            // widget.user!.start_time.toString(),
                            // widget.user!.end_time.toString(),
                            // phoneCon.text.toString(),
                            // widget.user!.password.toString(),
                            // widget.user!.email.toString(),
                            // widget.user!.city_name.toString(),
                            // widget.user!.street_name.toString(),
                            // widget.user!.university_name.toString(),
                            // widget.user!.type_id.toString(),
                            // widget.user!.car.toString(),
                            // widget.user!.seats.toString(),
                            // widget.user!.car_number.toString(),
                            // widget.user!.cost.toString(),
                            // widget.user!.range.toString(),
                            // widget.user!.time.toString(),
                            // context
                          );
                        },
                        child: const Text("حفظ")),
                  ],
                ),
              ),
              const Icon(
                Icons.account_circle_rounded,
                size: 110,
                color: goodcolor,
              ),
              Center(
                child: Text(
                  widget.user!.name.toString(),
                  style: const TextStyle(
                      color: goodcolor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: goodcolor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: phoneCon,
                      // initialValue:
                      //     'رقم الجوال : ${widget.user!.phone.toString()}',
                      style: const TextStyle(color: goodcolor, fontSize: 16),
                      decoration: TextFieldDesign(),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: goodcolor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: TextFormField(
                      enabled: false,
                      controller: emailCon,
                      // initialValue:
                      //     'البريد الالكتروني: ${widget.user!.email.toString()}',
                      style: const TextStyle(color: goodcolor, fontSize: 16),
                      decoration: TextFieldDesign(),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: size.width * 0.75,
                height: 1,
                color: goodcolor,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.85,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Kbackground,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(),
                          Text(
                            "معلومات النقل:",
                            style: TextStyle(
                                fontSize: 18,
                                color: goodcolor,
                                fontWeight: FontWeight.bold),
                          ),
                          // Icon(
                          //   Icons.edit_note,
                          //   size: 40,
                          //   color: goodcolor,
                          // )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(children: [
                              const Text(
                                "الجهة التعليمية: ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(widget.user!.university_name.toString())
                            ]),
                          ),
                          SizedBox(
                            //width: 90,
                            child: Row(
                              children: [
                                const Text(
                                  "الحي: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(widget.user!.street_name.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(children: [
                              const Text(
                                "التكلفة: ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(widget.user!.cost.toString())
                            ]),
                          ),
                          SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                const Text(
                                  "الفترة: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(widget.user!.time.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.75,
                height: 1,
                color: goodcolor,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.85,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Kbackground,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(),
                          Text(
                            "معلومات المركبة:",
                            style: TextStyle(
                                fontSize: 18,
                                color: goodcolor,
                                fontWeight: FontWeight.bold),
                          ),
                          // Icon(
                          //   Icons.edit_note,
                          //   size: 40,
                          //   color: goodcolor,
                          // )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(children: [
                              const Text(
                                "نوع السيارة: ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(widget.user!.car.toString())
                            ]),
                          ),
                          SizedBox(
                            // width: 90,
                            child: Row(
                              children: [
                                const Text(
                                  "رقم السيارة: ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(widget.user!.car_number.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration TextFieldDesign() {
    return InputDecoration(
      hintStyle: const TextStyle(fontSize: 13),
      fillColor: Colors.grey[200],
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: goodcolor3, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: goodcolor3)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: goodcolor3)),
    );
  }
}
