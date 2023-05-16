import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              )),
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
                      "حول",
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
                const SizedBox(
                  width: 300,
                  child: Text(
                    "مسارنا أول تطبيق يجمع بين الطلاب والسائقين لتسهيل رحلة وصولهم لوجهاتهم التعليمية بكل يسر وامان",
                    style: TextStyle(color: goodcolor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  "خدماتنا",
                  style: TextStyle(
                      color: goodcolor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const AboutSubject(
                  title: "للطلاب",
                  icon: Icons.group,
                  description:
                      "نوفر لطلاب منصه موثوقه للبحث عن السائقين والتواصل معهم ودفع تكاليف التوصيل الكترونياً",
                ),
                const AboutSubject(
                  title: "للسائقين",
                  icon: Icons.directions_bus_sharp,
                  description:
                      "نوفر منصه تساعد السائقين على عرض خدماتهم والحصول على عملاء والتنسيق معهم بالإضافة الى مساعدتهم في تنظيم وتسهيل رحلة اصطحاب الركاب ونقلهم لمقرهم الدراسي",
                ),
              ],
            ),
          ),
        ));
  }
}

class AboutSubject extends StatelessWidget {
  const AboutSubject(
      {Key? key,
      required this.title,
      required this.description,
      required this.icon})
      : super(key: key);
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          SizedBox(
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: goodcolor3,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: goodcolor3,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            description,
            style:
                const TextStyle(color: goodcolor, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
