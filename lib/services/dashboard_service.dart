import '../models/entry.dart';
import '../models/frequency.dart';

class DashboardService {
  double calculateTotalSavings(List<Entry> entries) {
    if (entries.isEmpty) {
      return 0.0;
    }

    double totalSavings = 0.0;

    for (Entry entry in entries) {
      if (entry.frequency != Frequency.SINGLE) {
        totalSavings += calculateTotalSavingsOfRecurrentEntry(entry);
      } else {
        totalSavings += entry.saved;
      }
    }

    return totalSavings;
  }

  double calculateSavingsStatusInPercent(
      List<Entry> entries, double savingsGoal) {
    double totalSavings = calculateTotalSavings(entries);
    double savingsStatusInPercent = totalSavings / savingsGoal;
    return savingsStatusInPercent > 1 ? 1 : savingsStatusInPercent;
  }

  double calculateRemainingAmount(List<Entry> entries, double savingsGoal) {
    double totalSavings = calculateTotalSavings(entries);
    double remainingAmount = savingsGoal - totalSavings;
    return remainingAmount < 0 ? 0 : remainingAmount;
  }

  double calculateTotalSavingsOfRecurrentEntry(Entry entry) {
    DateTime currentDate = DateTime.now();
    double totalSavings = 0;

    // Check if the starting date is in the future
    if (entry.startingDate.isAfter(currentDate)) {
      return totalSavings; // Savings haven't started yet.
    }

    // Calculate how many times saving occurred within the time period between
    // startingDate and currentDate
    int yearsDiff = currentDate.year - entry.startingDate.year;
    int monthsDiff = currentDate.month - entry.startingDate.month;
    int daysDiff = currentDate.day - entry.startingDate.day;

    int totalDaysDiff = yearsDiff * 365 + monthsDiff * 30 + daysDiff;

    // Calculate the number of full cycles completed
    int fullCycles = 0;
    switch (entry.frequency) {
      case Frequency.DAILY:
        fullCycles = totalDaysDiff;
        break;
      case Frequency.WEEKLY:
        fullCycles = totalDaysDiff ~/ 7;
        break;
      case Frequency.MONTHLY:
        fullCycles = totalDaysDiff ~/ 30;
        break;
      case Frequency.YEARLY:
        fullCycles = yearsDiff;
        break;
      case Frequency.SINGLE:
        fullCycles = 1;
        break;
    }

    // Calculate savings for full cycles and add the initial savings
    totalSavings = entry.saved * fullCycles + entry.saved;

    return totalSavings;
  }
}
