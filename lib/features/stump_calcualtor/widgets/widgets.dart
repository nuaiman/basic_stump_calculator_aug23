import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StumpSizeBuilder extends StatelessWidget {
  final String headerText;
  final String identifierText;
  final String hintText;
  final Color identifierColor;
  final IconData icon;
  final Function(String value) onChanged;
  TextEditingController controller;
  StumpSizeBuilder({
    super.key,
    required this.headerText,
    required this.identifierText,
    required this.hintText,
    required this.identifierColor,
    required this.icon,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: const TextStyle(
              fontFamily: 'Bangers', fontSize: 18, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              identifierText,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: identifierColor,
                  fontFamily: 'Bangers',
                  fontSize: 48,
                  color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  controller.text = value;
                  onChanged(value);
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
                  prefixIcon: Icon(icon),
                  hintText: hintText,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
