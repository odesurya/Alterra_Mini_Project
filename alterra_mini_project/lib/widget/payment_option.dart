import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String label;
  final Widget image;
  final bool value;
  final Function(bool?) onChanged;

  const PaymentOption({
    Key? key,
    required this.label,
    required this.image,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        const SizedBox(width: 8),
        Text(label),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
