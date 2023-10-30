import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/frequency.dart';

class FrequencyFactory {
  static Frequency createFrequency(int frequency) {
    switch (frequency) {
      case 0:
        return Frequency.SINGLE;
      case 1:
        return Frequency.DAILY;
      case 2:
        return Frequency.WEEKLY;
      case 3:
        return Frequency.MONTHLY;
      case 4:
        return Frequency.YEARLY;
      default:
        return Frequency.DAILY;
    }
  }

  static String createFrequencyString(
      Frequency frequency, BuildContext context) {
    switch (frequency) {
      case Frequency.DAILY:
        return AppLocalizations.of(context).day;
      case Frequency.WEEKLY:
        return AppLocalizations.of(context).week;
      case Frequency.MONTHLY:
        return AppLocalizations.of(context).month;
      case Frequency.YEARLY:
        return AppLocalizations.of(context).year;
      default:
        return AppLocalizations.of(context).day;
    }
  }
}
