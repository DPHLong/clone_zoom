import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/screens/meeting_screen.dart';
import 'package:clone_zoom/screens/contacts_screen.dart';
import 'package:clone_zoom/screens/history_screen.dart';
import 'package:clone_zoom/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    MeetingScreen(),
    const HistoryScreen(),
    const ContactsScreen(),
    const SettingsScreen(),
  ];
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        backgroundColor: footerColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        onTap: (value) {
          setState(() => _pageIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock),
            label: 'Meetings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
