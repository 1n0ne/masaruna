// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final Control _Control = Control();

  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController topicCont = TextEditingController();
  TextEditingController supCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 80,
          width: size.width * 0.75,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: goodcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "تواصل معنا",
                style: TextStyle(
                    color: goodcolor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: nameCont,
                    decoration: TextFieldDesign(
                      "الاسم",
                    )),
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    controller: emailCont,
                    decoration: TextFieldDesign(
                      "البريد الالكتروني",
                    )),
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                    controller: topicCont,
                    textAlign: TextAlign.center,
                    decoration: TextFieldDesign(
                      "الموضوع",
                    )),
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                    controller: supCont,
                    maxLines: 10,
                    textAlign: TextAlign.center,
                    decoration: TextFieldDesign(
                      "الوصف",
                    )),
              ),
              SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => goodcolor2),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      onPressed: () {
                        _Control.contact_us(
                            context,
                            nameCont.text.toString(),
                            emailCont.text.toString(),
                            topicCont.text.toString(),
                            supCont.text.toString());
                      },
                      child: const Text(
                        "إرسال",
                        style: TextStyle(fontSize: 22),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration TextFieldDesign(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 17),
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
    );
  }
}
