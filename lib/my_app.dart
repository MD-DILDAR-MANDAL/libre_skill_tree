import 'package:flutter/material.dart';
import 'package:libre_skill_tree/features/home/home_screen.dart';
import 'package:libre_skill_tree/features/profile/screens/profile_screen.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';
import 'package:libre_skill_tree/features/skill_tree/screens/skill_tree_screen.dart';

class MyApp extends StatefulWidget {
  final SkillTreeRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: AppNavigation(repository: widget.repository),
    );
  }
}

class AppNavigation extends StatefulWidget {
  final SkillTreeRepository repository;
  const AppNavigation({super.key, required this.repository});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.engineering_outlined),
            label: 'Skill tree',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        selectedIndex: currentPageIndex,
        labelTextStyle: WidgetStateProperty<TextStyle>.fromMap(
          <WidgetStatesConstraint, TextStyle>{
            WidgetState.selected: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            WidgetState.any: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          },
        ),
      ),
      body: <Widget>[
        HomeScreen(),
        SkillTreeScreen(repository: widget.repository),
        ProfileScreen(),
      ][currentPageIndex],
    );
  }
}
