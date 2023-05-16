// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldCont = TextEditingController();
  TextEditingController newCont = TextEditingController();
  TextEditingController confCont = TextEditingController();
  final Control _control = Control();
  bool oldpassword = true, newpassword = true, renewpassword = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text("تغيير كلمة المرور"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: 750,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: oldCont,
                        textAlign: TextAlign.center,
                        obscureText: oldpassword,
                        decoration: TextFieldDesign(
                            "كلمة المرور السابقة",
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    oldpassword = !oldpassword;
                                  });
                                },
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined))),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: newCont,
                        textAlign: TextAlign.center,
                        obscureText: newpassword,
                        decoration: TextFieldDesign(
                            "كلمة المرور الجديدة",
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    newpassword = !newpassword;
                                  });
                                },
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined))),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: confCont,
                        textAlign: TextAlign.center,
                        obscureText: renewpassword,
                        decoration: TextFieldDesign(
                            "التحقق من كلمة المرور الجديدة",
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    renewpassword = !renewpassword;
                                  });
                                },
                                icon:
                                    const Icon(Icons.remove_red_eye_outlined))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: size.width * 0.7,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ))),
                            onPressed: () {
                              if (oldCont.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'يرجى ادخال كلمة المرور القديمة',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              } else if (newCont.text.toString() ==
                                  confCont.text.toString()) {
                                _control.update_password(
                                    context,
                                    oldCont.text.toString(),
                                    newCont.text.toString());
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'يرجى التحقق من تطابق كلمة المرور',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            child: const Text(
                              "تغيير",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ],
                ),
              ),
              Image.asset('assets/images/RestPassword.png')
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration TextFieldDesign(String hint, Widget widget) {
    return InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13),
        fillColor: Colors.grey[200],
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: goodcolor3, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: goodcolor3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: goodcolor3)),
        suffixIcon: widget);
  }
}
