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
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Image.asset('assets/images/stumpSize.png'),
                ),
                const SizedBox(height: 40),
                StumpSizeBuilder(
                  controller: _widthController,
                  headerText: 'Width: length between the two furthest point.',
                  identifierText: 'A - B',
                  identifierColor: Colors.red,
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
                  identifierColor: Colors.amber,
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
                  identifierText: 'C - D',
                  identifierColor: Colors.green,
                  onChanged: (String value) {
                    setState(() {
                      _priceController.text = value;
                    });
                  },
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PricePage(
                    width: double.parse(_widthController.text),
                    height: double.parse(_heightController.text),
                    price: double.parse(_priceController.text),
                  ),
                ));
              },
        child: Container(
          width: double.infinity,
          height: 60,
          color: Colors.amber,
          child: const Center(
            child: Text(
              'Submit',
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
