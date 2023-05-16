// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masaruna/auth/signUp/signUpDriver/info_Driver.dart';
import 'package:masaruna/auth/signUp/signUpDriver/info_Driver2.dart';

class StepperDriver extends StatefulWidget {
  const StepperDriver({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _StepperDriverState createState() => _StepperDriverState();
}

class _StepperDriverState extends State<StepperDriver> {
  int currentStep = 1;
  String? driver_name_step,
      driver_sex_step,
      driver_city_step,
      driver_street_step;
  File? imageFile;
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
              child: info_Driver(
                pressd: () {
                  driver_name_step = driver_name;
                  imageFile = imageFile;
                  driver_sex_step = driver_sex;
                  driver_city_step = driver_city;
                  driver_street_step = driver_street;
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
              child: info_Driver2(
                id: widget.id,
                driver_name_2: driver_name_step,
                imageFile: imageFile,
                driver_sex_2: driver_sex_step,
                driver_city_2: driver_city_step,
                driver_street_2: driver_street_step,
              )),
        ),
      ),
    ];
  }
}
