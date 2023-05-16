// ignore_for_file: non_constant_identifier_names, camel_case_types, unused_field, file_names, prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print

import 'dart:async';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import '../../../controls/user_control.dart';
import '../../../model/city_model.dart';
import '../../../model/streets_model.dart';

import 'package:image_picker/image_picker.dart';

String? driver_name, driver_sex, driver_city, driver_street;
File? imageFile;

class info_Driver extends StatefulWidget {
  const info_Driver({
    super.key,
    required this.pressd,
  });
  final Function pressd;

  @override
  State<info_Driver> createState() => _info_DriverState();
}

class _info_DriverState extends State<info_Driver> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isImage = false;

  PickedFile? pickedFile;

  File? file;
  final imagepicker = ImagePicker();
  var imagname;
  TextEditingController nameController = TextEditingController();
  String cityController = "";
  String streetController = "";
  TextEditingController PhoneController = TextEditingController();
  final User_Control _user_control = User_Control();
  List<citie_model> citys = [];
  bool isloading = true;
  get_cities() {
    _user_control.get_cities().then((value) => setState(() {
          citys = value!;
          get_streets();
        }));
  }

  List<streets_model> streets = [];

  get_streets() {
    _user_control.get_streets().then((value) => setState(() {
          streets = value!;
          isloading = false;
        }));
  }

  var maleOrFemale;
  String? latitude;
  String? longitude;

  @override
  void initState() {
    get_streets();
    get_cities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            form(nameController, 'الاسم'),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: const [
                Text(
                  'الصورة الشخصية:',
                  style: TextStyle(fontSize: 20, color: goodcolor),
                ),
              ],
            ),
            const Icon(
              Icons.image,
              size: 100,
            ),
            ElevatedButton(
                onPressed: () async {
                  _getFromGallery();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return dashboard();
                  // }));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: goodcolor2,
                    minimumSize: const Size(50, 30)),
                child: SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.cloud_upload_rounded),
                      Text(
                        'رفع',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الجنس:',
                  style: TextStyle(fontSize: 20, color: goodcolor),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.63,
                    child: Row(children: [
                      Row(children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "ذكر",
                              groupValue: maleOrFemale,
                              onChanged: (value) {
                                setState(() {
                                  maleOrFemale = value;
                                });
                              },
                            ),
                            const Text(
                              'ذكر',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Colors.black,
                              value: "انثى",
                              groupValue: maleOrFemale,
                              onChanged: (value) {
                                setState(() {
                                  maleOrFemale = value;
                                });
                              },
                            ),
                            const Text(
                              'انثى',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ])
                    ])),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'المدينة :',
                  style: TextStyle(fontSize: 18, color: goodcolor),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 70,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    items: citys.map((e) {
                      return e.name.toString();
                    }).toList(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      textAlign: TextAlign.right,
                      dropdownSearchDecoration: InputDecorationStyle('الحي'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cityController = value.toString();
                      });
                    },
                  ),

                  //  SearchField(
                  //   /// hasOverlay: true,
                  //   controller: cityController,
                  //   searchInputDecoration: InputDecorationStyle('المدينة'),
                  //   suggestions: citys
                  //       .map(
                  //         (e) => SearchFieldListItem(
                  //           e.name,
                  //           item: e.name,
                  //           // Use child to show Custom Widgets in the suggestions
                  //           // defaults to Text widget
                  //           child: Center(
                  //             child: Text(e.name),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الحي :',
                  style: TextStyle(fontSize: 18, color: goodcolor),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 70,
                  child: DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    items: streets.map((e) {
                      return e.name.toString();
                    }).toList(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      textAlign: TextAlign.right,
                      dropdownSearchDecoration: InputDecorationStyle('الحي'),
                    ),
                    onChanged: (value) {
                      setState(() {
                        streetController = value.toString();
                      });
                    },
                  ),

                  //  SearchField(
                  //   /// hasOverlay: true,
                  //   controller: streetController,
                  //   searchInputDecoration: InputDecorationStyle('الحي'),
                  //   suggestions: streets
                  //       .map(
                  //         (e) => SearchFieldListItem(
                  //           e.name,
                  //           item: e.name,
                  //           // Use child to show Custom Widgets in the suggestions
                  //           // defaults to Text widget
                  //           child: Center(
                  //             child: Text(e.name),
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    cityController != "" &&
                    streetController != "" &&
                    imageFile != null &&
                    maleOrFemale != null) {
                  // driver_image = imagname;
                  driver_name = nameController.text.toString();
                  driver_sex = maleOrFemale.toString();
                  driver_city = cityController.toString();
                  driver_street = streetController.toString();
                  widget.pressd();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'احد الحقول فارغ',
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(width: 2.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: const Color(0xFF7D9D9C),
                  minimumSize: const Size(190, 50)),
              child: const Text(
                'التالي',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.7968485797, 44.989873295),
    zoom: 8,
  );

  Set<Marker> myMarker = {
    const Marker(
        draggable: true,
        markerId: MarkerId('1'),
        position: LatLng(22.796848545776797, 44.989871489393295))
  };

  Widget form(controllerText, String Title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$Title :',
          style: const TextStyle(fontSize: 18, color: goodcolor),
        ),
        SizedBox(
          height: 70,
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            textAlign: TextAlign.center,
            cursorColor: Colors.black,
            controller: controllerText,
            decoration: InputDecorationStyle(Title),
          ),
        ),
      ],
    );
  }

  InputDecoration InputDecorationStyle(String Title) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      filled: true,
      fillColor: const Color(0xFFF0EFEF),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xff576f72))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xff576f72))),
      suffixIcon: Title == "الاسم"
          ? const SizedBox()
          : const Icon(
              Icons.search,
            ),
    );
  }

  _getFromGallery() async {
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);

      setState(() {
        isImage = true;
      });

      print(imageFile);
    }
  }
}
