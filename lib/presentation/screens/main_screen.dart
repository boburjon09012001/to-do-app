import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'second_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Widget> screen = [
    const MyHomePageScreen(),
    const SecondPage(),
    Container(),
    Container()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: screen.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Colors.grey.shade200,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/home1.svg',
                color: Colors.deepPurple,
                width: 28,
              ),
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: Colors.grey.shade500,
                width: 24,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/cal.svg',
                  color: Colors.deepPurple,
                  width: 28,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/cal.svg',
                  color: Colors.grey.shade500,
                  width: 24,
                ),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  color: Colors.deepPurple,
                  width: 28,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/notification.svg',
                  color: Colors.grey,
                  width: 24,
                ),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color: Colors.deepPurple,
                  width: 35,
                ),
                icon: SvgPicture.asset(
                  'assets/icons/search.svg',
                  color: Colors.grey,
                  width: 33,
                ),
                label: ''),
          ],
          currentIndex: selectedIndex,
          onTap: (int i) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      ),
    );
  }
}