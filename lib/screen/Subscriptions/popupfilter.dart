// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:masaruna/constant.dart';
// import 'package:masaruna/controls/control.dart';
// import 'package:masaruna/screen/Subscriptions/subscribenow.dart';
// import 'package:masaruna/screen/Subscriptions/subscriptions.dart';

// class PopUpFilter extends StatefulWidget {
//   const PopUpFilter({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<PopUpFilter> createState() => _PopUpFilterState();
// }

// class _PopUpFilterState extends State<PopUpFilter> {
//   Control _control = Control();
//   double _currentSliderValue = 300;
//   @override
//   Widget build(BuildContext context) {
//     return newMethod();
//   }

//   PopupMenuButton<int> newMethod() {
//     return PopupMenuButton(
//         constraints: BoxConstraints(minHeight: 200, minWidth: 250),
//         position: PopupMenuPosition.under,
//         elevation: 50,
//         padding: EdgeInsets.zero,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15.0))),
//         icon: Icon(
//           Icons.filter_alt_rounded,
//           color: goodcolor,
//           size: 50,
//         ),
//         itemBuilder: (context) {
//           return [
//             PopupMenuItem<int>(
//               value: 7,
//               padding: EdgeInsets.zero,
//               child: StatefulBuilder(
//                   builder: (BuildContext context, StateSetter setState) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(right: 15),
//                       child: Text(
//                         "السعر: ",
//                         style: TextStyle(
//                             color: goodcolor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                     Stack(
//                       children: [
//                         Container(
//                           height: 70,
//                           width: 250,
//                           child: Column(
//                             children: [
//                               Expanded(child: SizedBox()),
//                               Text(
//                                 "${_currentSliderValue.toInt()} ر.س",
//                                 textAlign: TextAlign.center,
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20),
//                           child: Slider(
//                             value: _currentSliderValue,
//                             max: 1000,
//                             divisions: 300,
//                             label: _currentSliderValue.round().toString(),
//                             onChanged: (double value) {
//                               setState(() {
//                                 _currentSliderValue = value;
//                               });
//                             },
//                             onChangeEnd: (value) {
//                               _control
//                                   .get_cost_drivers(value.toString())
//                                   .then((value) {
//                                 setState() {
//                                   Ldriver = value!;
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ),
//             PopupMenuItem<int>(
//               value: 8,
//               padding: EdgeInsets.zero,
//               child: StatefulBuilder(
//                   builder: (BuildContext context, StateSetter setState) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(right: 15),
//                       child: Text(
//                         "التقييم: ",
//                         style: TextStyle(
//                             color: goodcolor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                     Stack(
//                       children: [
//                         Container(
//                           height: 70,
//                           width: 250,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(right: 20),
//                           margin: EdgeInsets.only(right: 15),
//                           child: RatingBar.builder(
//                               initialRating: 1,
//                               itemCount: 5,
//                               itemBuilder: (context, index) {
//                                 switch (index) {
//                                   case 0:
//                                     return Icon(
//                                       Icons.star,
//                                       color: goodcolor,
//                                     );
//                                   case 1:
//                                     return Icon(
//                                       Icons.star,
//                                       color: goodcolor,
//                                     );
//                                   case 2:
//                                     return Icon(
//                                       Icons.star,
//                                       color: goodcolor,
//                                     );
//                                   case 3:
//                                     return Icon(
//                                       Icons.star,
//                                       color: goodcolor,
//                                     );
//                                   case 4:
//                                     return Icon(
//                                       Icons.star,
//                                       color: goodcolor,
//                                     );
//                                 }
//                                 ;
//                                 return SizedBox();
//                               },
//                               onRatingUpdate: (rating) {
//                                 print(rating);
//                               }),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ];
//         },
//         onSelected: (value) {
//           switch (value) {
//             case 0:
//               break;
//             case 1:
//               break;
//             case 2:
//               break;
//             case 3:
//               break;
//             case 4:
//               break;
//             case 5:
//               break;
//             case 6:
//               break;
//             case 7:
//               break;
//             case 8:
//               break;
//           }
//         });
//   }
// }

// class MenuOption extends StatelessWidget {
//   const MenuOption({Key? key, required this.title, required this.icon})
//       : super(key: key);
//   final String title;
//   final IconData icon;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(right: 30),
//       margin: EdgeInsets.symmetric(horizontal: 5),
//       width: 145,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Icon(
//             icon,
//             color: goodcolor,
//           ),
//           Text(
//             title,
//             style: const TextStyle(color: goodcolor),
//           ),
//         ],
//       ),
//     );
//   }
// }
