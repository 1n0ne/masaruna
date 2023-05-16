// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:masaruna/constant.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:masaruna/controls/control.dart';

import '../../model/driver_model.dart';

class PaymentPage extends StatefulWidget {
  driver_model driver;

  PaymentPage({super.key, required this.driver});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardb = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدفع"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: size.width * 0.8,
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "فاتورة الإشتراك",
                        style: TextStyle(
                            color: goodcolor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "تكلفة الاشتراك/الشهر: ",
                            style: TextStyle(
                                color: goodcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "350 ر.س",
                            style: TextStyle(
                                color: goodcolor3,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "مدة الاشتراك المحدد: ",
                            style: TextStyle(
                                color: goodcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "ترم",
                            style: TextStyle(
                                color: goodcolor3,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        width: size.width * 0.8,
                        height: 2,
                        color: goodcolor4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "الاجمالي:",
                            style: TextStyle(
                                color: goodcolor,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "1050 ر.س",
                            style: TextStyle(
                                color: goodcolor3,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Kbackground,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "اختر طريقة الدفع",
                          style: TextStyle(
                              color: goodcolor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        PaymentWidget(driver: widget.driver),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentWidget extends StatefulWidget {
  driver_model driver;

  PaymentWidget({super.key, required this.driver});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final Control _control = Control();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        width: size.width * 0.85,
        child: _buildPanel(size),
      ),
    );
  }

  Widget _buildPanel(Size size) {
    return ExpansionPanelList.radio(
        animationDuration: const Duration(milliseconds: 600),
        initialOpenPanelValue: 0,
        children: [
          ExpansionPanelRadio(
              backgroundColor: Kbackground,
              canTapOnHeader: true,
              value: 0,
              headerBuilder: ((context, isExpanded) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Image(
                          image: AssetImage('assets/images/mada.png'),
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'الدفع ببطاقة مدى',
                          style: TextStyle(
                              color: goodcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )),
              body: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: TextFieldDesign("____ ____ ____ ____"),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: size.width * 0.38,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: TextFieldDesign("MM/YY"),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: size.width * 0.38,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: TextFieldDesign("CVC"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.8,
                      height: 50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: TextFieldDesign("اسم صاحب البطاقة"),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            _control.update_subscribe(
                                '2', widget.driver.id.toString(), context);
                          },
                          child: const Text("تأكيد")),
                    )
                  ],
                ),
              )),
          ExpansionPanelRadio(
              backgroundColor: Kbackground,
              canTapOnHeader: true,
              value: 1,
              headerBuilder: ((context, isExpanded) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Image(
                          image: AssetImage('assets/images/paypal.png'),
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'باي بال (paypal)',
                          style: TextStyle(
                              color: goodcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )),
              body: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => (const Color.fromARGB(
                                      255, 25, 134, 223))),
                            ),
                            onPressed: () {
                              _control.update_subscribe(
                                  '2', widget.driver.id.toString(), context);
                            },
                            child: const Text(
                              "باي بال",
                              style:
                                  TextStyle(color: Colors.yellow, fontSize: 22),
                            )),
                      ),
                    ],
                  ))),
          ExpansionPanelRadio(
              backgroundColor: Kbackground,
              canTapOnHeader: true,
              value: 2,
              headerBuilder: ((context, isExpanded) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Image(
                          image: AssetImage('assets/images/apple.png'),
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ابل باي (apple pay)',
                          style: TextStyle(
                              color: goodcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  )),
              body: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      (const Color.fromARGB(255, 68, 68, 68))),
                            ),
                            onPressed: () {
                              _control.update_subscribe(
                                  '2', widget.driver.id.toString(), context);
                            },
                            child: const Text(
                              "ابل باي",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 22),
                            )),
                      ),
                    ],
                  )))
        ]);
  }

  InputDecoration TextFieldDesign(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 17, color: goodcolor4),
      fillColor: Colors.grey[200],
      filled: true,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: goodcolor3, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: goodcolor3)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: goodcolor3)),
    );
  }
}
