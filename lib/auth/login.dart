// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, duplicate_ignore, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:masaruna/auth/signUp/signUp.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:masaruna/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_Driver/dashboard_Driver.dart';
import 'Forgot_your_password.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  final User_Control _user_control = User_Control();

  check() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get('id').toString();
    String type = prefs.get('type').toString();

    print('123123  $token');
    print('asdsad $type');

    if (token != 'null') {
      if (type.toString() == '1') {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const dashboard()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const dashboard_Driver()),
            (Route<dynamic> route) => false);
      }
    } else {}
  }

  @override
  void initState() {
    check();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      width: wi,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/Logo.png',
              height: 100,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'تسجيل الدخول',
              style: TextStyle(
                  color: Color(0xff576f72),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            form(emailCont, 'البريد الالكتروني', TextInputType.emailAddress),
            const SizedBox(
              height: 25,
            ),
            form(passCont, 'كلمة المرور', TextInputType.visiblePassword),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(
                    color: Color(0xff576f72),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const Forgot_your_password();
                    }));
                  },
                  child: const Text(
                    'اضغط هنا',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff576f72),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 85,
            ),
            ElevatedButton(
                onPressed: () {
                  _user_control.login(context, emailCont.text.toString(),
                      passCont.text.toString());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFF7D9D9C),
                    minimumSize: const Size(185, 50)),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ليس لديك حساب ؟ ',
                  style: TextStyle(
                    color: Color(0xff576f72),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const signUp()));
                  },
                  child: const Text(
                    'إنشاء حساب',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff576f72),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 250,
          child: TextFormField(
            textAlign: TextAlign.center,
            obscureText: type == TextInputType.visiblePassword ? true : false,
            keyboardType: type,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: const Color(0xFFF0EFEF),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xff576f72))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xff576f72))),
              hintText: Title,
              hintStyle: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
