import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PercentProgressCard extends StatefulWidget {
  const PercentProgressCard({
    super.key,
    required this.savingStatusInPercent,
  });

  final double savingStatusInPercent;

  @override
  State<PercentProgressCard> createState() => _PercentProgressCardState();
}

class _PercentProgressCardState extends State<PercentProgressCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInCirc,
                tween: Tween<double>(
                  begin: 0,
                  end: widget.savingStatusInPercent,
                ),
                builder: (context, value, _) => CircularProgressIndicator(
                  backgroundColor: Colors.white60,
                  value: value,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '${(widget.savingStatusInPercent * 100).toStringAsFixed(0)}${AppLocalizations.of(context).percent}',
                style: const TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
