// ignore_for_file: use_build_context_synchronously

import 'package:masaruna/auth/login.dart';
import 'package:masaruna/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../PopUpPages/about.dart';
import '../PopUpPages/ratepage.dart';
import '../PopUpPages/settings.dart';
import 'package:flutter/material.dart';

class PopupMenuOption extends StatelessWidget {
  const PopupMenuOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        icon: const Icon(
          Icons.keyboard_control_outlined,
          color: goodcolor,
          size: 55,
        ),
        itemBuilder: (context) {
          return const [
            PopupMenuItem<int>(
              padding: EdgeInsets.zero,
              value: 0,
              child: MenuOption(
                title: "الاعدادات",
                icon: Icons.settings,
              ),
            ),
            PopupMenuItem<int>(
              padding: EdgeInsets.zero,
              value: 1,
              child: MenuOption(
                title: "تقييم",
                icon: Icons.list,
              ),
            ),
            PopupMenuItem<int>(
              padding: EdgeInsets.zero,
              value: 2,
              child: MenuOption(
                title: "حول",
                icon: Icons.info_outline,
              ),
            ),
            PopupMenuItem<int>(
              padding: EdgeInsets.zero,
              value: 3,
              child: MenuOption(
                title: "تسجيل خروج",
                icon: Icons.logout,
              ),
            ),
          ];
        },
        onSelected: (value) async {
          switch (value) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RatePage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()));
              break;
            case 3:
              {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                // prefs.remove('key');

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const loginPage()),
                    (route) => false);
              }

              break;
          }
          // if (value == 0) {
          //   print("My account menu is selected.");
          // } else if (value == 1) {
          //   print("Settings menu is selected.");
          // } else if (value == 2) {
          //   print("Logout menu is selected.");
          // }
        });
  }
}

class MenuOption extends StatelessWidget {
  const MenuOption({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: goodcolor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(color: goodcolor),
          ),
        ],
      ),
    );
  }
}
