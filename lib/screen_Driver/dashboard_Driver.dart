// ignore_for_file: camel_case_types, file_names, unused_local_variable

import 'package:flutter/material.dart';
import '../auth/signUp/signUpDriver/profile_Driver.dart';
import '../constant.dart';
import 'Subscriptions_Driver/subscriptions_Driver.dart';
import 'driver_location_students.dart';
import 'homepage_Driver.dart';

class dashboard_Driver extends StatefulWidget {
  const dashboard_Driver({super.key});

  @override
  State<dashboard_Driver> createState() => _dashboard_DriverState();
}

class _dashboard_DriverState extends State<dashboard_Driver> {
  int _selectedIndex = 0;

  // ignore: prefer_final_fields
  static List _widgetOptions = [
    const HomePageWidget_Driver(),
    const Driver_Location_Sudents(),
    const SubscriptionsWidget_Driver(),
    const profile_Driver()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        child: BottomNavigationBar(
          unselectedItemColor: goodcolor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 45,
          backgroundColor: Kbackground,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(Icons.location_on),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              activeIcon: Icon(Icons.groups_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: goodcolor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
