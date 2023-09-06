import 'package:flutter/material.dart';

class SavingsInformationCard extends StatelessWidget {
  const SavingsInformationCard({
    super.key,
    required this.infoNumber,
    required this.infoText,
  });

  final double infoNumber;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              infoNumber.toStringAsFixed(2) + ' €',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              infoText,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

