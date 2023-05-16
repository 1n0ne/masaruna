// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masaruna/constant.dart';

class DriverRate extends StatelessWidget {
  const DriverRate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 45,
            ),
            const Text(
              "قيم",
              style: TextStyle(
                  color: goodcolor, fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 35,
                  color: goodcolor,
                )),
          ],
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "ما مدى تقييمك للسائق؟",
                style: TextStyle(color: goodcolor3),
              ),
              const Text("تقييمك ل خالد"),
              RatingBar.builder(
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 1:
                        return const Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 2:
                        return const Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 3:
                        return const Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                      case 4:
                        return const Icon(
                          Icons.star,
                          color: goodcolor,
                        );
                    }
                    return const SizedBox();
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => goodcolor3),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "ارسال",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ));
  }
}
