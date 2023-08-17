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

  double _priceController = 4;

  @override
  void initState() {
    _widthController.clear();
    _heightController.clear();
    super.initState();
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  double totalPrice = 0;

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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.asset('assets/images/stumpSize.png'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Width & Height: length between the two furthest point.',
                    style: TextStyle(
                        fontFamily: 'Bangers',
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      StumpSizeBuilder(
                        controller: _widthController,
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
                      StumpSizeBuilder(
                        controller: _heightController,
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Price: per inch in width (A-B).',
                    style: TextStyle(
                        fontFamily: 'Bangers',
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _priceController = double.parse(value);
                      });
                    },
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontFamily: 'Bangers'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      prefixIcon: const Icon(Icons.attach_money),
                      hintText: _priceController.toString(),
                      hintStyle:
                          const TextStyle(fontSize: 20, fontFamily: 'Bangers'),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          color: Colors.amber,
                          child: Center(
                            child: Text(
                              '\$ $totalPrice',
                              style: const TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _widthController.text.isEmpty ||
                            _heightController.text.isEmpty
                        ? () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter a wigth and height')));
                          }
                        : () {
                            getStumpPrice(
                              double.parse(_heightController.text),
                              double.parse(_widthController.text),
                              _priceController,
                            );
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
                ],
              ),
            ),
          ),
        ),
      ),
      // -----------------------------------------------------------------------
    );
  }
}
