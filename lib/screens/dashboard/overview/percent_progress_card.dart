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
  late double _circularProgressDiameter;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final CustomThemeExtension customTheme =
        Theme.of(context).extension<CustomThemeExtension>()!;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        _circularProgressDiameter =
            _calculateCircularProgressDiameter(height, width);

        return Card(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: _circularProgressDiameter,
                  height: _circularProgressDiameter,
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
      },
    );
  }

  double _calculateCircularProgressDiameter(double height, double width) {
    if (height > width) {
      return width * 0.8;
    }
    return height * 0.8;
  }

  String _getSavingStatusInPercentAsString() {
    final savingStatus = widget.savingStatusInPercent * 100;
    if (savingStatus < 1 && savingStatus > 0) {
      return '< 1';
    }
    return savingStatus.toStringAsFixed(0);
  }
}
