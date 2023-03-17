import 'package:flutter/material.dart';

import '../utils/app_utils.dart';
import '../screens/registration_screen.dart';
import '../controllers/account_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() => setState(() => _obscureText = !_obscureText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 35, 55),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
        child: GestureDetector(
          child: RichText(
            text: const TextSpan(
              text: 'New User?  ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Register Now',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => AppUtils.switchScreen(const RegistrationScreen(), context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'images/icon.png',
                  width: 67,
                  height: 67,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Email',
                    ),
                    controller: controllerEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                  child: TextFormField(
                    obscureText: _obscureText,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _obscureText ? const Icon(Icons.visibility, color: Colors.white) : const Icon(Icons.visibility_off, color: Colors.white),
                        onPressed: () => _togglePasswordVisibility(),
                      ),
                    ),
                    controller: controllerPassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      child: const Text(
                        'Login',
                      ),
                      onPressed: () => AccountController(context: context).signIn(controllerEmail.text.toLowerCase().trim(), controllerPassword.text),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
