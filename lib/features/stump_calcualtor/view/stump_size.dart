import 'dart:js_interop';

import 'price_page.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class StumpSize extends StatefulWidget {
  const StumpSize({super.key});

  @override
  State<StumpSize> createState() => _StumpSizeState();
}

class _StumpSizeState extends State<StumpSize> {
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    _widthController.clear();
    _heightController.clear();
    _priceController.clear();
    super.initState();
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  double? totalPrice;

  void getStumpPrice(double height, double width, double price) {
    // Tree dimensions
    double widthInch = width;
    double heightInch = height;

    // Price per inch for width
    double widthPricePerInch = price;

    // Calculate total price for width
    double totalWidthPrice = widthInch * widthPricePerInch;

    // Calculate price for height
    double heightPrice = 0;

    if (heightInch > 24) {
      // Price for the first 12 inches (free)
      heightPrice += totalWidthPrice * 0 * 12;

      // Price for the next 12 inches (from 12 - 24 inches)
      heightPrice += totalWidthPrice * 0.01 * (heightInch - 24 - 12);

      // Price for anything above 24 inches
      heightPrice += totalWidthPrice * 0.2;
    } else if (heightInch > 12) {
      // Price for the first 12 inches (free)
      heightPrice += totalWidthPrice * 0 * 12;

      // Price for the next (heightInch - 12) inches
      heightPrice += totalWidthPrice * 0.01 * (heightInch - 12);
    } else {
      // Price for the first (heightInch) inches (free)
      heightPrice += totalWidthPrice * 0 * heightInch;
    }

    // Calculate total cutting price
    double totalCuttingPrice = totalWidthPrice + heightPrice;
    setState(() {
      totalPrice = totalCuttingPrice;
    });

    // Display the result
    // print("Width: $widthInch inches");
    // print("Height: $heightInch inches");
    // print("Cutting Price: \$${totalCuttingPrice.toStringAsFixed(2)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFa4b0a2),
              Color(0xFF5a635c),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'What is the width between the two furthest point?',
                  style: TextStyle(
                    fontFamily: 'Bangers',
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 0),
                (_heightController.text.isEmpty ||
                        _widthController.text.isEmpty ||
                        _priceController.text.isEmpty)
                    ? SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: Image.asset('assets/images/stumpSize.png'),
                      )
                    : totalPrice.isNull
                        ? SizedBox(
                            height: 280,
                            width: double.infinity,
                            child: Image.asset('assets/images/stumpSize.png'),
                          )
                        : Center(
                            child: SizedBox(
                            height: 280,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '\$ ${totalPrice.toString()}',
                                style: const TextStyle(
                                  fontSize: 100,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                const SizedBox(height: 40),
                StumpSizeBuilder(
                  controller: _widthController,
                  headerText: 'Width: length between the two furthest point.',
                  identifierText: 'A - B',
                  hintText: 'inch',
                  identifierColor: Colors.red,
                  icon: Icons.straighten,
                  onChanged: (String value) {
                    setState(() {
                      _widthController.text = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                StumpSizeBuilder(
                  controller: _heightController,
                  headerText: 'Height: length from top to bottom.',
                  identifierText: 'C - D',
                  hintText: 'inch',
                  identifierColor: Colors.amber,
                  icon: Icons.straighten,
                  onChanged: (String value) {
                    setState(() {
                      _heightController.text = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                StumpSizeBuilder(
                  controller: _priceController,
                  headerText: 'Price: per inch in width.',
                  identifierText: 'A - B',
                  hintText: '',
                  identifierColor: Colors.green,
                  icon: Icons.attach_money,
                  onChanged: (String value) {
                    setState(() {
                      _priceController.text = value;
                    });
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
        ),
      ),
      // -----------------------------------------------------------------------
      bottomNavigationBar: GestureDetector(
        onTap: _widthController.text.isEmpty || _heightController.text.isEmpty
            ? () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please enter a wigth and height')));
              }
            : () {
                getStumpPrice(
                  double.parse(_heightController.text),
                  double.parse(_widthController.text),
                  double.parse(_priceController.text),
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => PricePage(
                //     width: double.parse(_widthController.text),
                //     height: double.parse(_heightController.text),
                //     price: double.parse(_priceController.text),
                //   ),
                // ));
              },
        child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.amber,
          child: const Center(
            child: Text(
              'Calculate',
              style: TextStyle(
                fontFamily: 'Bangers',
                color: Colors.red,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
