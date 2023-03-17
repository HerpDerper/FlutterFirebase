import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../utils/app_utils.dart';
import '../screens/auth_screen.dart';
import '../controllers/account_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerBirthDate = TextEditingController();

  void _showDatePickerDialog() async {
    DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now());
    if (pickedDate != null) {
      setState(() => controllerBirthDate.text = DateFormat('dd.MM.yyyy').format(pickedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 35, 55),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
        child: GestureDetector(
          child: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Already registered?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => AppUtils.switchScreen(const AuthScreen(), context),
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
                    'Create an account',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Email',
                    ),
                    controller: controllerEmail,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Email must not be empty';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Email entered incorrectly';
                      }
                      return null;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Username',
                    ),
                    controller: controllerUsername,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Username must not be empty';
                      }
                      if (value.length < 8 || value.length >= 16) {
                        return 'Username must be from 8 to 16 characters';
                      }
                      return null;
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Password',
                    ),
                    controller: controllerPassword,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Password must not be empty';
                      }
                      if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$').hasMatch(value)) {
                        return 'Password must be from 8 to 16 characters, must contain letters, numbers and special characters';
                      }
                      return null;
                    }),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 8, 30, 0),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelText: 'Birthdate',
                    ),
                    controller: controllerBirthDate,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Birthdate must not be empty';
                      }
                      if (DateTime.parse(controllerBirthDate.text).isBefore(DateTime.now())) {
                        return 'Birthdate must be less than the current date';
                      }
                      return null;
                    }),
                    onTap: () => _showDatePickerDialog(),
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
                        'Register',
                      ),
                      onPressed: () => AccountController(context: context).createAccount(
                          controllerEmail.text.toLowerCase().trim(), controllerUsername.text.trim(), controllerPassword.text, controllerBirthDate.text),
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
