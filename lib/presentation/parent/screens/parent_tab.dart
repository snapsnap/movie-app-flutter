import 'package:flutter/material.dart';

import '../../home/screens/home.dart';
import '../../setting/screens/setting.dart';

class ParentTab extends StatefulWidget {
  const ParentTab({super.key});

  @override
  State<ParentTab> createState() => _ParentTabState();
}

class _ParentTabState extends State<ParentTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var pageList = [
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        // backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
              applyTextScaling: true,
            ),
            label: "Movies",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              applyTextScaling: true,
            ),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
