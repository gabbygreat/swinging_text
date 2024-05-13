import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn/screen/home.dart';
import 'package:learn/screen/profile.dart';
import 'package:learn/screen/settings.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell shell;
  const MainScreen({
    super.key,
    required this.shell,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        changeIndex(tabController.index);
      });
  }

  void changeIndex(int index) {
    widget.shell.goBranch(index);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: tabController,
        onTap: changeIndex,
        tabs: const [
          Tab(
            text: 'Home',
          ),
          Tab(
            text: 'Profile',
          ),
          Tab(
            text: 'Settings',
          ),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          HomeScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
