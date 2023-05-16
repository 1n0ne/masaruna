// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, avoid_print

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/model/day_model.dart';
import 'package:masaruna/model/user_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:masaruna/screen/dashboard.dart';
import '../constant.dart';
import '../controls/user_control.dart';
import '../model/city_model.dart';
import '../model/streets_model.dart';
import '../model/universities_model.dart';

class edit_profile extends StatefulWidget {
  edit_profile({super.key, required this.personalName, required this.user});
  final String personalName;

  user_model? user;
  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  DateTime? outTime;
  DateTime? inTime;

  String? start_time;
  String? end_time;
  get_Pro() {
    inTime = DateTime.tryParse(widget.user!.start_time);
    outTime = DateTime.tryParse(widget.user!.end_time);

    nameController.text = widget.user!.name.toString();
    phoneController.text = widget.user!.phone.toString();
    emailController.text = widget.user!.email.toString();
    addressController.text =
        '${widget.user!.city_name} , ${widget.user!.street_name}';
    cityController = widget.user!.city_name.toString();
    streetController = widget.user!.street_name.toString();
    UniversityController = widget.user!.university_name.toString();
  }

  String cityController = "";
  String streetController = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String UniversityController = "";

  bool Sunday = false;
  bool Monday = false;
  bool Tuesday = false;
  bool Wednesday = false;
  bool Thursday = false;

  DateTime in_dateTime = DateTime.now();
  DateTime out_dateTime = DateTime.now();
  bool isloading = true;

  final User_Control _user_control = User_Control();
  List<universities_model> universities = [];

  get_universities() {
    _user_control.get_universities().then((value) => setState(() {
          universities = value!;
          isloading = false;
        }));
  }

  List<citie_model> citys = [];

  get_cities() {
    _user_control.get_cities().then((value) => setState(() {
          citys = value!;
          get_streets();
        }));
  }

  List<streets_model> streets = [];

  get_streets() {
    _user_control.get_streets().then((value) => setState(() {
          streets = value!;
          isloading = false;
        }));
  }

  List<day_model>? days = [];
  get_day() async {
    await _user_control.get_my_days().then((value) => setState(() {
          days = value!;
        }));

    for (int i = 0; i < days!.length; i++) {
      if (days![i].id.toString() == '1') {
        setState(() {
          Sunday = true;
        });
      }
      if (days![i].id.toString() == '2') {
        setState(() {
          Monday = true;
        });
      }
      if (days![i].id.toString() == '3') {
        setState(() {
          Tuesday = true;
        });
      }
      if (days![i].id.toString() == '4') {
        setState(() {
          Wednesday = true;
        });
      }
      if (days![i].id.toString() == '5') {
        setState(() {
          Thursday = true;
        });
      }
    }
  }

  @override
  void initState() {
    get_Pro();
    get_universities();
    get_cities();
    get_streets();
    get_day();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب'),
        centerTitle: true,
        leading: const SizedBox(),
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
                size: 40,
                color: goodcolor,
              )),
        ],
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //    Text(days![0].name.toString()),
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
                          name: widget.personalName.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: form(
                          nameController,
                          widget.personalName,
                          TextInputType.name,
                          const SizedBox(
                            width: 0,
                          ),
                          const SizedBox(
                            width: 0,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    form(
                        phoneController,
                        '050******',
                        TextInputType.phone,
                        const SizedBox(),
                        const Icon(
                          Icons.phone,
                          size: 30,
                          color: goodcolor,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    form(
                        emailController,
                        'mariam***@gmail.com',
                        TextInputType.emailAddress,
                        const SizedBox(),
                        const Icon(
                          Icons.email,
                          size: 30,
                          color: goodcolor,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<String>(
                      selectedItem: cityController,
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      items: citys.map((e) {
                        return e.name.toString();
                      }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          textAlign: TextAlign.right,
                          dropdownSearchDecoration: FormDisgn(
                            "Title",
                            const SizedBox(),
                            const Icon(
                              Icons.location_on,
                              color: goodcolor,
                              size: 30,
                            ),
                          )),
                      onChanged: (value) {
                        setState(() {
                          cityController = value.toString();
                        });
                      },
                    ),
                    // TextFormField(
                    //     controller: cityController,
                    //     decoration: FormDisgn(
                    //       "",
                    //       SizedBox(),
                    //       Icon(
                    //         Icons.location_on,
                    //         color: goodcolor,
                    //         size: 30,
                    //       ),
                    //     ),
                    //     readOnly: true,
                    //     onTap: () {
                    //     }),
                    // SearchField(
                    //   hasOverlay: true,
                    //   controller: cityController,
                    //   searchInputDecoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black38),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     filled: true,
                    //     fillColor: Color(0xFFF0EFEF),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(color: Colors.black38)),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(color: Colors.black)),
                    //     hintStyle: TextStyle(
                    //         color: Colors.black54,
                    //         fontSize: 15,
                    //         fontFamily: 'Tajawal'),
                    //     prefixIcon: Icon(
                    //       Icons.location_on,
                    //       color: goodcolor,
                    //       size: 30,
                    //     ),
                    //   ),
                    //   suggestions: citys
                    //       .map(
                    //         (e) => SearchFieldListItem(
                    //           e.name,
                    //           item: e.name,
                    //           // Use child to show Custom Widgets in the suggestions
                    //           // defaults to Text widget
                    //           child: Center(
                    //             child: Text(
                    //               e.name,
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<String>(
                      selectedItem: streetController,
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      items: streets.map((e) {
                        return e.name.toString();
                      }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          textAlign: TextAlign.right,
                          dropdownSearchDecoration: FormDisgn(
                            "Title",
                            const SizedBox(),
                            const Icon(
                              Icons.add_location_alt_rounded,
                              color: goodcolor,
                              size: 30,
                            ),
                          )),
                      onChanged: (value) {
                        setState(() {
                          streetController = value.toString();
                        });
                      },
                    ),
                    // SearchField(
                    //   hasOverlay: true,
                    //   controller: streetController,
                    //   searchInputDecoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.black38),
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     filled: true,
                    //     fillColor: Color(0xFFF0EFEF),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(color: Colors.black38)),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //         borderSide: BorderSide(color: Colors.black)),
                    //     hintStyle: TextStyle(
                    //         color: Colors.black54,
                    //         fontSize: 15,
                    //         fontFamily: 'Tajawal'),
                    //     prefixIcon: Icon(
                    //       Icons.add_location_alt_rounded,
                    //       color: goodcolor,
                    //       size: 30,
                    //     ),
                    //   ),
                    //   suggestions: streets
                    //       .map(
                    //         (e) => SearchFieldListItem(
                    //           e.name,
                    //           item: e.name,
                    //           // Use child to show Custom Widgets in the suggestions
                    //           // defaults to Text widget
                    //           child: Center(
                    //             child: Text(
                    //               e.name,
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownSearch<String>(
                      selectedItem: UniversityController,
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      items: universities.map((e) {
                        return e.name.toString();
                      }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          textAlign: TextAlign.right,
                          dropdownSearchDecoration: FormDisgn(
                            "Title",
                            const SizedBox(),
                            const Icon(
                              Icons.school_rounded,
                              color: goodcolor,
                              size: 30,
                            ),
                          )),
                      onChanged: (value) {
                        setState(() {
                          streetController = value.toString();
                        });
                      },
                    ),
                    // SearchField(

                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 150,
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: goodcolor,
                                              value: Sunday,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  Sunday = newValue!;
                                                  newValue
                                                      ? _user_control.add_days(
                                                          '1', context)
                                                      : _user_control
                                                          .delete_day(
                                                              '1', context);
                                                });
                                              },
                                            ),
                                            const Text('الاحد'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: goodcolor,
                                              value: Monday,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  Monday = newValue!;
                                                  newValue
                                                      ? _user_control.add_days(
                                                          '2', context)
                                                      : _user_control
                                                          .delete_day(
                                                              '2', context);
                                                });
                                              },
                                            ),
                                            const Text('الاثنين'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: goodcolor,
                                              value: Tuesday,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  Tuesday = newValue!;
                                                  newValue
                                                      ? _user_control.add_days(
                                                          '3', context)
                                                      : _user_control
                                                          .delete_day(
                                                              '3', context);
                                                });
                                              },
                                            ),
                                            const Text('الثلاثاء'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: goodcolor,
                                              value: Wednesday,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  Wednesday = newValue!;
                                                  newValue
                                                      ? _user_control.add_days(
                                                          '4', context)
                                                      : _user_control
                                                          .delete_day(
                                                              '4', context);
                                                });
                                              },
                                            ),
                                            const Text('الاربعاء'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Checkbox(
                                              activeColor: goodcolor,
                                              value: Thursday,
                                              onChanged: (bool? newValue) {
                                                setState(() {
                                                  Thursday = newValue!;
                                                  newValue
                                                      ? _user_control.add_days(
                                                          '5', context)
                                                      : _user_control
                                                          .delete_day(
                                                              '5', context);
                                                });
                                              },
                                            ),
                                            const Text('الخميس'),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.watch_later,
                                            color: goodcolor,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'الحضور:',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: goodcolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: Kbackground,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: goodcolor2)),
                                        height: 95,
                                        width: 180,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (value) {
                                            in_dateTime = value;
                                            print(in_dateTime);
                                            start_time =
                                                '${in_dateTime.hour}:${in_dateTime.minute}';
                                          },
                                          initialDateTime: inTime,
                                          minimumYear: 2000,
                                          maximumYear: 3000,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.watch_later,
                                            color: goodcolor,
                                            size: 30,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'الإنصراف:',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: goodcolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: Kbackground,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: goodcolor2)),
                                        height: 95,
                                        width: 180,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (value) {
                                            in_dateTime = value;
                                            print(in_dateTime);

                                            end_time =
                                                '${in_dateTime.hour}:${in_dateTime.minute}';
                                          },
                                          initialDateTime: outTime,
                                          minimumYear: 2000,
                                          maximumYear: 3000,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _user_control.update_profile(
                              nameController.text.toString(),
                              widget.user!.gender.toString(),
                              widget.user!.home_number.toString(),
                              widget.user!.lat.toString(),
                              widget.user!.long.toString(),
                              start_time.toString(),
                              end_time.toString(),
                              phoneController.text.toString(),
                              widget.user!.password.toString(),
                              widget.user!.email.toString(),
                              cityController.toString(),
                              streetController.toString(),
                              UniversityController.toString(),
                              widget.user!.type_id.toString(),
                              widget.user!.car.toString(),
                              widget.user!.seats.toString(),
                              widget.user!.car_number.toString(),
                              widget.user!.cost.toString(),
                              widget.user!.range.toString(),
                              widget.user!.time.toString(),
                              context);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(width: 1.0, color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: const Color(0xFF7D9D9C),
                            minimumSize: const Size(70, 50)),
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.save_outlined),
                              Text(
                                'حفظ',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Column form(controllerText, String Title, TextInputType type, Widget icon,
      Widget prefix) {
    return Column(
      children: [
        SizedBox(
          //  padding: EdgeInsets.all(5),
          height: 60,
          child: TextFormField(
            enabled: controllerText == emailController ? false : true,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 14),
            keyboardType: type,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: FormDisgn(Title, icon, prefix),
          ),
        ),
      ],
    );
  }

  InputDecoration FormDisgn(String Title, Widget icon, Widget prefix) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: const Color(0xFFF0EFEF),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black38)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.black)),
      hintText: Title,
      suffixIcon: icon,
      prefixIcon: prefix,
      hintStyle: const TextStyle(
          color: Colors.black54, fontSize: 15, fontFamily: 'Tajawal'),
    );
  }
}
