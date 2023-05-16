// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/user_control.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OPT_Page extends StatefulWidget {
  const OPT_Page(
      {super.key,
      required this.type,
      required this.email,
      required this.pass,
      required this.phone,
      required this.verificationId});

  final String type;
  final String email;
  final String phone;
  final String pass;
  final String verificationId;
  @override
  State<OPT_Page> createState() => _OPT_PageState();
}

class _OPT_PageState extends State<OPT_Page> {
  final User_Control _user_control = User_Control();
  int c = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double hi = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: wi,
        height: hi,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/images/Verification.png',
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'التحقق من رقم الجوال',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: goodcolor),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'ادخل الرمز المكون من 6 ارقام',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: goodcolor),
              ),
              const SizedBox(
                height: 30,
              ),
              OTPTextField(
                outlineBorderRadius: 10,
                length: 6,
                width: 300,
                fieldWidth: 40,
                style: const TextStyle(fontSize: 17),
                otpFieldStyle: OtpFieldStyle(
                    focusBorderColor: Colors.black //(here)
                    ,
                    borderColor: Colors.black,
                    enabledBorderColor: Colors.black45),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: ((context) => StepperDriver(id: '5'))));
                  // try {
                  //   PhoneAuthCredential credential =
                  //       PhoneAuthProvider.credential(
                  //           verificationId: widget.verificationId,
                  //           smsCode: pin);
                  //   // Sign the user in (or link) with the credential
                  //   await auth.signInWithCredential(credential);
                  //   if (auth.currentUser != null) {
                  widget.type.toString() == '1'
                      ? _user_control.register_Stu(
                          widget.phone.toString(),
                          widget.email.toString(),
                          widget.pass.toString(),
                          widget.type.toString(),
                          context)
                      : _user_control.register_driver(
                          widget.phone.toString(),
                          widget.email.toString(),
                          widget.pass.toString(),
                          widget.type.toString(),
                          context);
                  //   }
                  // } on FirebaseAuthException {
                  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //     content: Text(
                  //       'خطأ في رمز التحقق',
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     backgroundColor: Colors.red,
                  //   ));
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
