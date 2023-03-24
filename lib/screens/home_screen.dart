import '../models/account.dart';
import '../pages/files_page.dart';
import '../pages/profile_page.dart';
import '../pages/accounts_page.dart';
import '../controllers/account_controller.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int currentIndex = 0;
  late AccountController controller;
  final List<Widget> pages = const [FilesPage(), AccountsPage(), ProfilePage()];

  @override
  void initState() {
    controller = AccountController(context: context, account: Account(email: '', userName: '', password: '', birthDate: ''));
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.updateStatus(true);
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller.updateStatus(false);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 35, 55),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          FilesPage(),
          AccountsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 22, 20, 32),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              size: 30,
              Icons.file_present_sharp,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              size: 30,
              Icons.emoji_people_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              size: 30,
              Icons.person,
            ),
          ),
        ],
        onTap: (value) => setState(() => currentIndex = value),
      ),
    );
  }
}
