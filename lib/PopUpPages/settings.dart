// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/PopUpPages/changepassword.dart';
import 'package:masaruna/PopUpPages/contactus.dart';
import 'package:masaruna/PopUpPages/policy.dart';
import 'package:masaruna/constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:masaruna/controls/user_control.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final User_Control _user_control = User_Control();
  bool status = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("الاعدادات"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 350,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SettingsOption(
                        size: size,
                        icon: Icons.edit_note,
                        title: "تغيير كلمة المرور",
                        widget: const Icon(
                          Icons.navigate_next_rounded,
                          size: 40,
                          color: goodcolor,
                        ),
                        push: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePassword()));
                        },
                      ),
                      SettingsOption(
                        size: size,
                        icon: Icons.notifications_off_outlined,
                        title: "الاشعارات",
                        widget: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: FlutterSwitch(
                            activeColor: (Colors.green[400])!,
                            width: 60.0,
                            height: 35.0,
                            toggleSize: 30.0,
                            value: status,
                            borderRadius: 30.0,
                            showOnOff: false,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ),
                        push: () {
                          null;
                        },
                      ),
                      SettingsOption(
                        size: size,
                        icon: Icons.message_outlined,
                        title: "تواصل معنا",
                        widget: const Icon(
                          Icons.navigate_next_rounded,
                          size: 40,
                          color: goodcolor,
                        ),
                        push: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const ContactUs())));
                        },
                      ),
                      SettingsOption(
                        size: size,
                        icon: Icons.receipt_outlined,
                        title: "السياسات والخصوصية",
                        widget: const Icon(
                          Icons.navigate_next_rounded,
                          size: 40,
                          color: goodcolor,
                        ),
                        push: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Policy())));
                        },
                      ),
                    ]),
              ),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => (Colors.red[300])!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        _user_control.delete_client(context);
                      },
                      child: const Text("حذف الحساب")))
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    Key? key,
    required this.size,
    required this.title,
    required this.icon,
    required this.widget,
    required this.push,
  }) : super(key: key);

  final Size size;
  final String title;
  final IconData icon;
  final Widget widget;
  final Function push;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.88,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: goodcolor, width: 1.5)),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              push();
            },
            child: Container(
              width: size.width * 0.80,
              height: 60,
              margin: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: goodcolor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, color: goodcolor),
                  ),
                ],
              ),
            ),
          ),
          Positioned(left: 0, top: 10, child: widget)
        ],
      ),
    );
  }
}
