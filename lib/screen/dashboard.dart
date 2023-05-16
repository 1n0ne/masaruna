// ignore_for_file: camel_case_types, unused_local_variable

import 'package:flutter/material.dart';
import '../auth/profile.dart';
import '../constant.dart';
import 'Subscriptions/subscriptions.dart';
import 'homepage.dart';
import 'locationscreeen.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int _selectedIndex = 0;

  // ignore: prefer_final_fields
  static const List _widgetOptions = [
    HomePageWidget(),
    LocationWidget(),
    SubscriptionsWidget(),
    profile()
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
              icon: Icon(Icons.directions_bus_outlined),
              activeIcon: Icon(Icons.directions_bus_sharp),
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
