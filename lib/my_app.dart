import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libre_skill_tree/core/constants/app_colors.dart';
import 'package:libre_skill_tree/features/home/home_screen.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_bloc.dart';
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
    SkillTreeRepository repository = widget.repository;
    return MultiBlocProvider(
      providers: [
        BlocProvider<SkillTreeBloc>(
          create: (BuildContext context) => SkillTreeBloc(repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        home: AppNavigation(repository: repository),
      ),
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
    final screens = [
      const HomeScreen(),
      SkillTreeScreen(repository: widget.repository),
    ];
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.appBackground,
        indicatorColor: Colors.deepOrangeAccent,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) =>
            setState(() => currentPageIndex = index),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.blueGrey),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined, color: Colors.blueGrey),
            selectedIcon: Icon(Icons.account_tree, color: Colors.white),
            label: 'Skill tree',
          ),
        ],
        labelTextStyle: WidgetStateProperty<TextStyle>.fromMap(
          <WidgetStatesConstraint, TextStyle>{
            WidgetState.selected: TextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.bold,
            ),
            WidgetState.any: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          },
        ),
      ),
    );
  }
}
