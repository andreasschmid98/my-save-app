import '../models/frequency.dart';

class FrequencyFactory {
  static Frequency create(int frequency) {
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
}