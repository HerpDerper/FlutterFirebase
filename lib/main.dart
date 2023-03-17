import '../screens/auth_screen.dart';
import '../screens/home_screen.dart';
import '../utils/firebase_utils.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseUtils.auth.currentUser == null ? const AuthScreen() : const HomeScreen(),
    );
  }
}
