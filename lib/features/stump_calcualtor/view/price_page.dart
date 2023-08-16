import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PricePage extends StatelessWidget {
  PricePage({
    Key? key,
    required this.height,
    required this.width,
    required this.price,
  }) : super(key: key);

  final double height;
  final double width;
  final double price;

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
    totalPrice = totalCuttingPrice;

    // Display the result
    // print("Width: $widthInch inches");
    // print("Height: $heightInch inches");
    // print("Cutting Price: \$${totalCuttingPrice.toStringAsFixed(2)}");
  }

  @override
  Widget build(BuildContext context) {
    getStumpPrice(height, width, price);
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.amber,
          child: const Center(
            child: Text(
              'Go Back',
              style: TextStyle(
                fontFamily: 'Bangers',
                color: Colors.red,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
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
                  'Pricing structure for basic stumps',
                  style: TextStyle(
                    fontFamily: 'Bangers',
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Per inch width cost is \$7',
                      style: TextStyle(
                        fontFamily: 'Bangers',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'First 12 inches of height is free',
                      style: TextStyle(
                        fontFamily: 'Bangers',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'From 12 to 24 inches in height adds 1% of every inch of the total width.',
                      style: TextStyle(
                        fontFamily: 'Bangers',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'For 24 inch and above we add a flat price of 20% of the total width for cutting it off.',
                      style: TextStyle(
                        fontFamily: 'Bangers',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Total: \$ ${totalPrice!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: 'Bangers',
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
