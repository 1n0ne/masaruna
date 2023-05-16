// ignore_for_file: non_constant_identifier_names, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, override_on_non_overriding_member, library_prefixes, depend_on_referenced_packages, unused_local_variable, deprecated_member_use, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:intl/intl.dart' as int;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../model/accepted_driver_subscribe_model.dart';

class Driver_Location_one extends StatefulWidget {
  Driver_Location_one(
      {Key? key,
      required this.student_location,
      required this.name,
      required this.id,
      required this.phone,
      required this.lat_driver,
      required this.long_driver})
      : super(key: key);
  accepted_driver_subscribe_model student_location;
  final String name;
  final String id;
  final String phone;
  final double lat_driver;
  final double long_driver;

  @override
  State<Driver_Location_one> createState() => _Driver_Location_oneState();
}

class _Driver_Location_oneState extends State<Driver_Location_one> {
  final Control _control = Control();
  bool isloading = false;

  @override
  void initState() {
    polylinePoints = PolylinePoints();

    ShowBottomSheet();
    get();

    super.initState();
  }

  @override
  final Completer<GoogleMapController> _controller = Completer();

  // List<LatLng> po = [];
  Set<Polyline> polyline = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  get() async {
    LatLng sourceLoc = LatLng(widget.lat_driver, widget.long_driver);
    LatLng destina = LatLng(double.parse(widget.student_location.student_lat),
        double.parse(widget.student_location.student_long));

    setPolylines();
    // PolylinePoints polygonPoints = PolylinePoints();
    // PolylineResult result = await polygonPoints.getRouteBetweenCoordinates(
    //     'AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4',
    //     PointLatLng(sourceLoc.latitude, sourceLoc.longitude),
    //     PointLatLng(destina.latitude, destina.longitude));

    // if (result.points.isNotEmpty) {
    //   for (var point in result.points) {
    //     po.add(LatLng(point.latitude, point.longitude));
    //   }
    //   setState(() {});
    // }
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4",
        PointLatLng(widget.lat_driver, widget.long_driver),
        PointLatLng(double.parse(widget.student_location.student_lat),
            double.parse(widget.student_location.student_long)));

    if (result.status == 'OK') {
      polylineCoordinates.clear();

      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setpolyline();
      setState(() {});
    }
  }

  setpolyline() {
    polyline.add(Polyline(
        width: 5,
        polylineId: const PolylineId('polyLine'),
        color: Colors.red,
        points: polylineCoordinates));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Set<Marker> myMarker = {
      Marker(
          draggable: true,
          markerId: const MarkerId('1'),
          position: LatLng(widget.lat_driver, widget.long_driver)),
      Marker(
          draggable: true,
          markerId: const MarkerId('2'),
          position: LatLng(double.parse(widget.student_location.student_lat),
              double.parse(widget.student_location.student_long)))
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: goodcolor,
        ),
        title: const Text(
          'الخريطة',
          style: TextStyle(color: goodcolor),
        ),
      ),
      body: isloading
          ? const SizedBox(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    polylines: polyline,
                    markers: myMarker,
                    onTap: (LatLng) {
                      ShowBottomSheet();
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.lat_driver, widget.long_driver),
                      zoom: 8,
                    ),
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  ShowBottomSheet() {
    Future.delayed(const Duration(seconds: 0)).then((_) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(25))),
              height: 120,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          size: 55,
                          color: goodcolor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                              color: goodcolor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                                onPressed: () {
                                  DateTime date = DateTime.now();
                                  String dateF =
                                      int.DateFormat('yyyy-MM-dd').format(date);

                                  _control.add_student_list(dateF.toString(),
                                      widget.id.toString(), context);
                                },
                                child: const Text("تم التوصيل"))),
                        IconButton(
                            onPressed: () {
                              UrlLauncher.launch(
                                  'tel:${widget.phone.toString()}');
                            },
                            icon: const Icon(
                              Icons.phone,
                              size: 30,
                              color: goodcolor,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}
