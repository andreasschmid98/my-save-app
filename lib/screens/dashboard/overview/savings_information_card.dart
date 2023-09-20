import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavingsInformationCard extends StatelessWidget {
  const SavingsInformationCard({
    super.key,
    required this.amount,
    required this.description,
  });

  final double amount;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    '${amount.toStringAsFixed(2)} ${AppLocalizations.of(context).euro}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                Text(
                  description.toUpperCase(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
