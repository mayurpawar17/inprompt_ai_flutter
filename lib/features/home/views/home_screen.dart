import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inprompt_ai_flutter/core/utils/helper_method.dart';

import '../../../core/utils/app_colors.dart';
import '../../gemini/views/home_screen.dart';
import '../widgets/nav_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = const [
    GeminiScreen(),
    Center(child: Text("Settings")),
  ];

  void _onTap(int index) {
    HapticFeedback.selectionClick();
    setState(() => _currentIndex = index);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.primaryColor,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.50,
          decoration: BoxDecoration(
            color: context.isDark
                ? AppColors.darkSecondary
                : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: 20,
            //     color: Colors.black.withOpacity(0.12),
            //     offset: const Offset(0, 4),
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavItem(
                icon: Icons.home,
                index: 0,
                currentIndex: _currentIndex,
                onTap: _onTap,
              ),
              NavItem(
                icon: Icons.settings,
                index: 1,
                currentIndex: _currentIndex,
                onTap: _onTap,
              ),
              // NavItem(
              //   icon: Icons.settings,
              //   index: 2,
              //   currentIndex: _currentIndex,
              //   onTap: _onTap,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
