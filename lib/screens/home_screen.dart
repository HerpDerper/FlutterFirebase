import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 35, 55),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are ${auth.currentUser!.isAnonymous ? 'anonymous' : auth.currentUser!.email}', style: const TextStyle(color: Colors.white, fontSize: 20)),
            const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 5)),
            ElevatedButton(onPressed: () => signOut(), child: const Text("Exit"))
          ],
        ),
      ),
    );
  }
}
