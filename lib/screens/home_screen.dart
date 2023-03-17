import '../models/account.dart';
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
          AccountsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 22, 20, 32),
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        items: [
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              size: 30,
              Icons.forum_rounded,
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              size: 30,
              Icons.emoji_people_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: StreamBuilder(
              stream: controller.getAccount(),
              builder: (context, snapshotAccount) {
                if (snapshotAccount.hasData) {
                  controller.account = snapshotAccount.data!;
                  controller.updateStatus(true);
                }
                return FutureBuilder(
                  future: controller.getAccountImage(),
                  builder: (context, snapshotImage) {
                    return CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        snapshotImage.data.toString(),
                      ),
                      child: CircleAvatar(
                        radius: 13.5,
                        backgroundColor: Colors.transparent,
                        child: Builder(
                          builder: (context) {
                            return Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: controller.account!.status ? Colors.green : Colors.grey,
                                radius: 3,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
        onTap: (value) => setState(() => currentIndex = value),
      ),
    );
  }
}
