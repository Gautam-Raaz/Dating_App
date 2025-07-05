import 'package:dating_app/screen/all_match.dart';
import 'package:dating_app/screen/home_screen.dart';
import 'package:dating_app/screen/profile_screen.dart';
import 'package:dating_app/screen/searchScreen.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    AllMatch(),
    ProfileScreen(),
  ];


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
            icon: Icon(Icons.home,color: _currentIndex == 0 ? const Color.fromARGB(255, 225, 109, 148): const Color.fromARGB(255, 231, 29, 43),),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _currentIndex == 1 ? const Color.fromARGB(255, 225, 109, 148): const Color.fromARGB(255, 231, 29, 43),),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,color: _currentIndex == 2 ? const Color.fromARGB(255, 225, 109, 148): const Color.fromARGB(255, 231, 29, 43),),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: _currentIndex == 3 ? const Color.fromARGB(255, 225, 109, 148): const Color.fromARGB(255, 231, 29, 43),),
            label: '',
          ),
        ],
      ),
    );
  }
}
