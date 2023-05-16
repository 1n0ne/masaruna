// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/screen/popup.dart';
import '../screen/notification.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  TextEditingController suggestionCont = TextEditingController();
  final Control _control = Control();

  double ratings = 0.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo.png',
          height: 80,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const NotificationPage())));
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                size: 55,
                color: goodcolor,
              )),
        ],
        leading: Transform.rotate(
          angle: 90 * pi / 60,
          child: const PopupMenuOption(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: 600,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "تقييم التطبيق",
                      style: TextStyle(
                          color: goodcolor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 300,
                      height: 2,
                      color: goodcolor3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "ما مدى تقييمك لتطبيق مسارنا؟",
                      style: TextStyle(
                        color: goodcolor3,
                        fontSize: 20,
                      ),
                    ),
                    RatingBar.builder(
                        initialRating: 3,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return const Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: goodcolor,
                              );
                            case 1:
                              return const Icon(
                                Icons.sentiment_dissatisfied,
                                color: goodcolor,
                              );
                            case 2:
                              return const Icon(
                                Icons.sentiment_neutral,
                                color: goodcolor,
                              );
                            case 3:
                              return const Icon(
                                Icons.sentiment_satisfied,
                                color: goodcolor,
                              );
                            case 4:
                              return const Icon(
                                Icons.sentiment_very_satisfied,
                                color: goodcolor,
                              );
                          }
                          return const SizedBox();
                        },
                        onRatingUpdate: (rating) {
                          ratings = rating;
                        })
                  ],
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                      controller: suggestionCont,
                      maxLines: 10,
                      textAlign: TextAlign.center,
                      decoration: TextFieldDesign(
                        "للاقتراحات او الشكاوي....",
                      )),
                ),
                SizedBox(
                    height: 50,
                    width: size.width * 0.7,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => goodcolor2),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))),
                        onPressed: () {
                          if (suggestionCont.text.toString() == '') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'يرجى ادخال الاقتراحات او الشكوى',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            _control.add_rating(context, ratings.toString(),
                                suggestionCont.text.toString());
                          }
                        },
                        child: const Text(
                          "إرسال",
                          style: TextStyle(fontSize: 22),
                        ))),
              ]),
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
