import 'package:flutter/material.dart';
import 'package:movie_app/presentation/parent/provider/parent_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/di/get_it.dart';
import '../../home/provider/movie_provider.dart';
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
    ChangeNotifierProvider(
      create: (_) => MovieProvider(
          getNowPlayingMoviesUseCase: getIt(),
          getPopularMoviesUseCase: getIt(),
          getTopRatedMoviesUseCase: getIt(),
          getUpcomingMoviesUseCase: getIt()),
      child: const HomePage(),
    ),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context);
    int selectedIndex = parentProvider.getSelectedIndex;

    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        currentIndex: selectedIndex,
        onTap: (value) {
          parentProvider.setIndex(value);
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
