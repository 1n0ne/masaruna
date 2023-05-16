// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, override_on_non_overriding_member, depend_on_referenced_packages, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaruna/constant.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart' as int;
import 'package:masaruna/model/accepted_driver_subscribe_model.dart';

import '../controls/control.dart';

class Driver_Location_Sudents extends StatefulWidget {
  const Driver_Location_Sudents({
    Key? key,
  }) : super(key: key);
  @override
  State<Driver_Location_Sudents> createState() =>
      _Driver_Location_SudentsState();
}

class _Driver_Location_SudentsState extends State<Driver_Location_Sudents> {
  BitmapDescriptor markicon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor studenticon = BitmapDescriptor.defaultMarker;
  void addicon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            "assets/images/bus.png")
        .then((icon) {
      setState(() {
        markicon = icon;
      });
    });
  }

  final Control _control = Control();
  bool isloading = false;
  DateTime date = DateTime.now();
  late Position cl;
  bool isStudent = true;
  List<accepted_driver_subscribe_model> accepted_driver_subscribe = [];
  get_accepted_driver_subscribe() {
    String dateF = int.DateFormat('yyyy-MM-dd').format(date);
    _control.get_accepted_driver_subscribe(dateF.toString()).then((value) {
      if (mounted) {
        setState(() {
          accepted_driver_subscribe = value!;
          isStudent = false;
        });
      }
    });
  }

  @override
  final Completer<GoogleMapController> _controller = Completer();

  var latitude_;
  var longitude_;
  // List<LatLng> po = [];
  List<LatLng> x = [];
  Set<Polyline> polyline = <Polyline>{};
  late PolylinePoints polylinePoints;
  get() async {
    setPolylines();
    // LatLng sourceLoc = LatLng(x[0].latitude, x[0].longitude);
    // LatLng destina = LatLng(x.latitude, x[1].longitude);
    // PolylinePoints polygonPoints = PolylinePoints();
    // for (var i = 0; i < x.length - 1; i++) {
    //   PolylineResult result = await polygonPoints.getRouteBetweenCoordinates(
    //       'AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4',
    //       PointLatLng(x[i].latitude, x[i].longitude),
    //       PointLatLng(x[i + 1].latitude, x[i + 1].longitude));
    //   if (result.points.isNotEmpty) {
    //     for (var point in result.points) {
    //       po.add(LatLng(point.latitude, point.longitude));
    //     }
    //     setState(() {});
    //   }
    // }
  }

  setPolylines() async {
    // for (var i = 0; i < x.length - 1; i++) {
    //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //       'AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4',
    //       PointLatLng(x[i].latitude, x[i].longitude),
    //       PointLatLng(x[i + 1].latitude, x[i + 1].longitude));
    //   if (result.points.isNotEmpty) {
    //     for (var point in result.points) {
    //       po.add(LatLng(point.latitude, point.longitude));
    //     }
    //     setpolyline();

    //     setState(() {});
    //   }
    // }
    for (var i = 0; i < x.length - 1; i++) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyAc4K9kZM9QitCAppry8TMcEgvtzXfKm-4",
          PointLatLng(x[i].latitude, x[i].longitude),
          PointLatLng(x[i + 1].latitude, x[i + 1].longitude));

      if (result.status == 'OK') {
        x.clear();

        for (var point in result.points) {
          x.add(LatLng(point.latitude, point.longitude));
        }
      }
    }
  }

  setpolyline() {
    polyline.add(Polyline(
        width: 5,
        polylineId: const PolylineId('polyLine'),
        color: Colors.red,
        points: x));
  }

  @override
  void initState() {
    polylinePoints = PolylinePoints();

    addicon();
    getPostion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> myMarker = x.map(
      (e) {
        var i = x.indexOf(e);
        return Marker(
            icon: i == 0 ? markicon : studenticon,
            draggable: true,
            markerId: MarkerId(e.toString()),
            position: LatLng(e.latitude, e.longitude));
      },
    ).toList();

    return isloading
        ? const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: goodcolor,
            )),
          )
        : isStudent == false
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    'الخريطة',
                    style: TextStyle(color: goodcolor),
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        onTap: (LatLng) {
                          ShowBottomSheet();
                        },
                        polylines: polyline,
                        markers: myMarker.toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(32.524410, 39.818989),
                          zoom: 5,
                        ),
                        zoomControlsEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
  }

  Future getPostion() async {
    await get_accepted_driver_subscribe();
    bool services;
    services = await Geolocator.isLocationServiceEnabled();

    LocationPermission per;
    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    if (per != LocationPermission.denied) {
      await getLatAndLong();
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);

    setState(() {
      latitude_ = cl.latitude;
      longitude_ = cl.longitude;
      x = [
        LatLng(latitude_, longitude_),
      ];

      for (var studnt_location in accepted_driver_subscribe) {
        x.add(
            LatLng(studnt_location.student_lat, studnt_location.student_long));
      }
      isloading = false;
    });

    ShowBottomSheet();
  }

  ShowBottomSheet() {
    Future.delayed(const Duration(seconds: 6)).then((_) {
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
                  child: Center(
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                          onPressed: () async {
                            await get();
                          },
                          child: const Text("إبدأ")),
                    ),
                  )),
            );
          });
    });
  }
}
