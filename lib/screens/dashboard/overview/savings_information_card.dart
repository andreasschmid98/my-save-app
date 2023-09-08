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
    return Container(
      height: 100,
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    infoNumber.toStringAsFixed(2) + ' €',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Text(
                  infoText.toUpperCase(),
                  style: TextStyle(fontSize: 15),
                  // Die FontWeight-Eigenschaft wurde hinzugefügt, um den Text fett darzustellen.
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
