import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_save_app/theme/custom_theme_extension.dart';

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
    final CustomThemeExtension customTheme =
        Theme.of(context).extension<CustomThemeExtension>()!;

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
                  backgroundColor: customTheme.progressBarColor,
                  value: value,
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '${_getSavingStatusInPercentAsString()}${AppLocalizations.of(context).percent}',
                style: TextStyle(
                    fontSize: 30, color: customTheme.percentProgressColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  String _getSavingStatusInPercentAsString() {
    final savingStatus = widget.savingStatusInPercent * 100;
    if (savingStatus < 1 && savingStatus > 0) {
      return '< 1';
    }
    return savingStatus.toStringAsFixed(0);
  }
}
