import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../calender_screen/calender_screen.dart';
import '../home_screen/home.dart';
import '../notes_screen/notes_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    CalendarScreen(),
    NotesScreen(),
    ProfileScreen(),
  ];

  Color primaryColorT = Color(0xff02227a); // Example color
  Color unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: primaryColorT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
            backgroundColor: primaryColorT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
            backgroundColor: primaryColorT,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: primaryColorT,
          ),
        ],
      ),
    );
  }
}