import 'package:flutter/material.dart';

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your Location',
              suffixIcon: const Icon(Icons.search),
              contentPadding:
                  const EdgeInsets.only(top: 20, bottom: 5, right: 5, left: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.white)))),
    );
  }
}
