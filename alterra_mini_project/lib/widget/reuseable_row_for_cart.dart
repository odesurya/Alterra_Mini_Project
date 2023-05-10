import 'package:flutter/material.dart';

import 'reuseable_text.dart';

class ReuseableRowForCart extends StatelessWidget {
  const ReuseableRowForCart({
    Key? key,
    required this.text,
    required this.price,
  }) : super(key: key);

  final double price;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          ReuseableText(
            price: price,
          )
        ],
      ),
    );
  }
}
