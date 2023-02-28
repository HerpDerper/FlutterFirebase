import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> with WidgetsBindingObserver {
  TextEditingController controllerEmail = TextEditingController(text: 'eduardkutermin@gmail.com');
  TextEditingController controllerPassword = TextEditingController(text: 'passWord11');
  GlobalKey<FormState> key = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;

  void authLinkToEmail(String email) async {
    try {
      ActionCodeSettings acs = ActionCodeSettings(
          url: 'https://herpderp11.page.link/HD?email=$email',
          handleCodeInApp: true,
          androidPackageName: 'com.example.flutter_firebase',
          androidInstallApp: false);
      await FirebaseAuth.instance.sendSignInLinkToEmail(email: email, actionCodeSettings: acs).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('A link has been sent to your email', textAlign: TextAlign.center)));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString(), textAlign: TextAlign.center)));
    }
  }

  void authWithEmailAndPassword(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid email or password', textAlign: TextAlign.center)));
    }
  }

  void authAnonymously() async {
    await auth.signInAnonymously().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  void getDynamicLinkAndSignIn() async {
    PendingDynamicLinkData? dynamicLink = await FirebaseDynamicLinks.instance.onLink.first;

    if (dynamicLink != null) {
      String link = dynamicLink.link.toString();
      if (auth.isSignInWithEmailLink(link)) {
        String continueUrl = dynamicLink.link.queryParameters['continueUrl']!;
        String email = Uri.parse(continueUrl).queryParameters['email']!;

        await auth.signInWithEmailLink(email: email, emailLink: link);

        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }
  }

  @override
  void initState() {
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
      getDynamicLinkAndSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 99, 141, 219),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(controller: controllerEmail, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Email")),
                  const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 10)),
                  TextFormField(controller: controllerPassword, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Password")),
                  const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 5)),
                  ElevatedButton(
                      onPressed: () => authWithEmailAndPassword(controllerEmail.text.trim(), controllerPassword.text.trim()), child: const Text("Log in")),
                  const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 0)),
                  ElevatedButton(onPressed: () => authAnonymously(), child: const Text("Log in anonymously")),
                  const Padding(padding: EdgeInsets.fromLTRB(25, 5, 25, 0)),
                  ElevatedButton(onPressed: () => authLinkToEmail(controllerEmail.text.trim()), child: const Text("Log in using the email link")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
