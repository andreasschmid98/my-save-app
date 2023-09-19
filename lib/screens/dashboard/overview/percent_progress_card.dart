import 'package:flutter/material.dart';
import 'package:savings_tracker_app/screens/shared/constants.dart';

class PercentProgressCard extends StatelessWidget {
  const PercentProgressCard({
    super.key,
    required this.savingStatusInPercent,
  });

  final double savingStatusInPercent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white60,
                value: savingStatusInPercent,
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '${(savingStatusInPercent * 100).toStringAsFixed(0)}${Constants.PERCENT}',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
