// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:masaruna/auth/signUp/info2.dart';
import 'package:masaruna/auth/signUp/infoUser.dart';

class StepperStudent extends StatefulWidget {
  const StepperStudent({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _StepperStudentState createState() => _StepperStudentState();
}

class _StepperStudentState extends State<StepperStudent> {
  String? student_name_stp,
      student_sex_stp,
      student_city_stp,
      student_street_stp,
      student_home_number_stp,
      student_long_stp,
      student_lant_stp;

  int currentStep = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          // padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 50),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Stepper(
              controlsBuilder: (context, controller) {
                return const SizedBox.shrink();
              },
              type: StepperType.horizontal,
              currentStep: currentStep,
              elevation: 0,
              onStepTapped: (step) => setState(() {
                step == 0 ? null : currentStep = step;
              }),
              steps: getSteps(),
            ),
          )),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: StepState.complete,
        isActive: currentStep >= 0,
        title: const SizedBox(),
        content: Column(
          children: const [],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
              height: 800,
              width: MediaQuery.of(context).size.width * 0.9,
              child: infoUser(
                pressd: () {
                  student_name_stp = student_name;
                  student_sex_stp = student_sex;
                  student_city_stp = student_city;
                  student_street_stp = student_street;
                  student_home_number_stp = student_home_number;
                  student_long_stp = student_long;
                  student_lant_stp = student_lant;
                  setState(() {
                    currentStep += 1;
                  });
                },
              )),
        ),
        title: const SizedBox(),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const SizedBox(),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
              height: 700,
              width: MediaQuery.of(context).size.width * 0.9,
              child: info2(
                id: widget.id,
                student_name_2: student_name_stp,
                student_sex_2: student_sex_stp,
                student_city_2: student_city_stp,
                student_street_2: student_street_stp,
                student_home_number_2: student_home_number_stp,
                student_long_2: student_long_stp,
                student_lant_2: student_lant_stp,
              )),
        ),
      ),
    ];
  }
}
