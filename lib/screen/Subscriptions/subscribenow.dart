// ignore_for_file: must_be_immutable, non_constant_identifier_names, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:masaruna/constant.dart';
import 'package:masaruna/controls/control.dart';
import 'package:masaruna/model/driver_model.dart';
import 'package:intl/intl.dart' as int;

import '../../Utils/URL.dart';

class SubscribeNowPage extends StatefulWidget {
  SubscribeNowPage({super.key, this.testlist});
  List<driver_model>? testlist;
  @override
  State<SubscribeNowPage> createState() => _SubscribeNowPageState();
}

class _SubscribeNowPageState extends State<SubscribeNowPage> {
  final Control _control = Control();
  bool isloading = true;
  double _currentSliderValue = 300;
  List<driver_model> Ldriver = [];
  bool isFil = false;
  get_drivers() {
    _control.get_city_drivers().then((value) {
      setState(() {
        widget.testlist != null ? Ldriver = widget.testlist! : Ldriver = value!;
        isloading = false;
      });
    });
  }

  @override
  void initState() {
    get_drivers();

    // refresh();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Kbackground,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 85,
        backgroundColor: Kbackground,
        title: const Text(
          'إشترك الآن',
          textAlign: TextAlign.center,
          style: TextStyle(color: goodcolor, fontSize: 22),
        ),
        centerTitle: true,
        leading: PopUpFilter(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: goodcolor,
                size: 35,
              ))
        ],
      ),
      body: isloading
          ? const SizedBox(
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: goodcolor,
              )),
            )
          : Center(
              child: Column(
                children: [
                  isFil
                      ? const SizedBox()
                      : Expanded(
                          child: SizedBox(
                          width: size.width * 0.8,
                          child: ListView.builder(
                            itemCount: Ldriver.length,
                            itemBuilder: (context, index) {
                              return SubscribeNowCard(
                                size: size,
                                driver: Ldriver[index],
                              );
                            },
                          ),
                        )),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }

  PopupMenuButton PopUpFilter() {
    return PopupMenuButton(
        constraints: const BoxConstraints(minHeight: 200, minWidth: 250),
        position: PopupMenuPosition.under,
        elevation: 50,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        icon: const Icon(
          Icons.filter_alt_rounded,
          color: goodcolor,
          size: 50,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 7,
              padding: EdgeInsets.zero,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Text(
                        "السعر: ",
                        style: TextStyle(
                            color: goodcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 70,
                          width: 250,
                          child: Column(
                            children: [
                              const Expanded(child: SizedBox()),
                              Text(
                                "${_currentSliderValue.toInt()} ر.س",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 20),
                          child: Slider(
                            value: _currentSliderValue,
                            max: 1000,
                            divisions: 300,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              _control
                                  .get_cost_drivers(value.toString())
                                  .then((value) {
                                setState(() {
                                  Ldriver = value!;
                                  isFil = true;
                                });
                                // Navigator.replace(
                                //   context,
                                //   oldRoute: MaterialPageRoute(
                                //       builder: (context) =>
                                //           SubscriptionsWidget()),
                                //   newRoute: MaterialPageRoute(
                                //       builder: (context) => SubscribeNowPage()),
                                // );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubscribeNowPage(
                                            testlist: Ldriver)));
                              });

                              setState((() {}));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            PopupMenuItem(
              value: 8,
              padding: EdgeInsets.zero,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Text(
                        "التقييم: ",
                        style: TextStyle(
                            color: goodcolor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Stack(
                      children: [
                        const SizedBox(
                          height: 70,
                          width: 250,
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(right: 15),
                          child: RatingBar.builder(
                              initialRating: 1,
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
                                _control
                                    .get_rate_drivers(rating.toString())
                                    .then((value) {
                                  setState(() {
                                    Ldriver = value!;
                                    isFil = true;
                                  });
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubscribeNowPage(
                                                  testlist: Ldriver)));
                                });

                                setState((() {}));

                                print(rating);
                              }),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ];
        },
        onSelected: (value) {
          switch (value) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              break;
            case 5:
              break;
            case 6:
              break;
            case 7:
              break;
            case 8:
              break;
          }
        });
  }
}

class SubscribeNowCard extends StatelessWidget {
  SubscribeNowCard({
    Key? key,
    required this.size,
    required this.driver,
  }) : super(key: key);

  final Size size;

  driver_model driver;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: size.width * 0.8,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: goodcolor, width: 2)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(
                  ImageUrl + driver.image.toString(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Icon(
            //   Icons.account_circle,
            //   color: goodcolor,
            //   size: 60,
            // ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  driver.name.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: goodcolor),
                ),
                RatingBarIndicator(
                  textDirection: TextDirection.ltr,
                  rating: driver.avg.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: goodcolor,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                )
              ],
            ),
            Expanded(
              child: Text(
                '${driver.cost} ر/س',
                textAlign: TextAlign.end,
                style: const TextStyle(color: goodcolor),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return SubscribeDialog(
                  driver: driver,
                );
              });
            });
      },
    );
  }
}

class SubscribeDialog extends StatefulWidget {
  driver_model driver;

  SubscribeDialog({Key? key, required this.driver}) : super(key: key);

  @override
  State<SubscribeDialog> createState() => _SubscribeDialogState();
}

class _SubscribeDialogState extends State<SubscribeDialog> {
  List<String> list = <String>['شهر', 'ترم', 'سنة'];
  final Control _control = Control();
  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
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
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spa,
                children: [
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 55,
                    color: goodcolor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          widget.driver.name.toString(),
                          style: const TextStyle(
                              color: goodcolor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      RatingBarIndicator(
                        textDirection: TextDirection.ltr,
                        rating: widget.driver.avg.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: goodcolor,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      )
                    ],
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
              Text(
                "نوع المركبة: ${widget.driver.car.toString()}",
                style: const TextStyle(color: goodcolor3),
              ),
              Text(
                "التكلفة: ${widget.driver.cost.toString()} ر.س/${widget.driver.range.toString()}",
                style: const TextStyle(color: goodcolor3),
              ),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: 175,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: goodcolor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: goodcolor,
                      size: 35,
                    ),
                    elevation: 16,
                    style: const TextStyle(
                        color: goodcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              }),
              SizedBox(
                width: 175,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => goodcolor3),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      var date = DateTime.now();

                      if (dropdownValue == 'شهر') {
                        var newDate =
                            DateTime(date.year, date.month + 1, date.day);
                        String dateF =
                            int.DateFormat('yyyy-MM-dd').format(newDate);

                        _control.add_subscribe(context,
                            widget.driver.id.toString(), dateF.toString());
                      } else if (dropdownValue == 'ترم') {
                        var newDate =
                            DateTime(date.year, date.month + 3, date.day);
                        String dateF =
                            int.DateFormat('yyyy-MM-dd').format(newDate);

                        _control.add_subscribe(context,
                            widget.driver.id.toString(), dateF.toString());
                      } else {
                        var newDate =
                            DateTime(date.year + 1, date.month, date.day);

                        String dateF =
                            int.DateFormat('yyyy-MM-dd').format(newDate);

                        _control.add_subscribe(context,
                            widget.driver.id.toString(), dateF.toString());
                      }
                    },
                    child: const Text(
                      "اشتراك",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ));
  }
}
