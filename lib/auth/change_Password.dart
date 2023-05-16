// ignore_for_file: camel_case_types, non_constant_identifier_names, unused_local_variable, file_names

import 'package:flutter/material.dart';

class change_Password extends StatefulWidget {
  const change_Password({super.key});

  @override
  State<change_Password> createState() => _change_PasswordState();
}

class _change_PasswordState extends State<change_Password> {
  TextEditingController passwordContr = TextEditingController();
  TextEditingController ConwordContr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7D9D9C),
        centerTitle: true,
        title: const Text('تغير كلمة المرور'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        width: wi,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              form(passwordContr, 'كلمة المرور الجديدة',
                  TextInputType.visiblePassword),
              const SizedBox(
                height: 30,
              ),
              form(passwordContr, 'التحقق من كلمة المرور الجديدة',
                  TextInputType.visiblePassword),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    // loginUser(type);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          // side: BorderSide(width: 1.0, color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: const Color(0xff80a3a2),
                      minimumSize: const Size(300, 50)),
                  child: const Text(
                    'ارسال',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              Image.asset('assets/images/RestPassword.png')
            ],
          ),
        ),
      ),
    );
  }

  Column form(controllerText, String Title, TextInputType type) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 250,
          child: TextFormField(
            textAlign: TextAlign.center,
            obscureText: false,
            keyboardType: type,
            cursorColor: Colors.black,
            // controller: controllerText,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 240, 239, 239),
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
