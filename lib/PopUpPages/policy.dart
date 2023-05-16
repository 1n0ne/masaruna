// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("السياسات و الخصوصية"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
        width: size.width,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "قد يتم جمع وتخزين واستخدام المعلومات الشخصية التالية :معلومات حول جهازك والموقع الجغرافي أيضا المعلومات التي تدخلها عند التسجيل في تطبيقنا مثل : عنوان بريدك الإلكتروني، اسمك ،صورة ملفك الشخصي ،الجنس أيضا المعلومات المتعلقة بالخدمات او المعلومات الواردة في أي مراسلات ترسلها إلينا عبر الصفحة تواصل معنا",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "نتعهد بعدم فقدان معلوماتك الشخصية او اساءة استخدامها او تغييرها",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "انت المسؤول عن الحفاظ على سرية كلمة المرور",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "لن يطلب منك كلمة المرور الخاصه بك الا عند تسجيل الدخول الى التطبيق",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "قد نكشف عن معلوماتك الشخصية فقط عندما يتعلق الامر بالاجراءت القانونية",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Kbackground,
                ),
                child: Text(
                  "قد نجري تغييرات او تحديثات على هذه السياسات في اي وقت",
                  style: Text_Style(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle Text_Style() {
    return const TextStyle(
        fontSize: 18, color: goodcolor, fontWeight: FontWeight.bold);
  }
}
