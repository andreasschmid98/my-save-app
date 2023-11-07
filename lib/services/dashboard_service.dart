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

    DateTime nextSavingDate = entry.startingDate;
    while (nextSavingDate.isBefore(currentDate)) {
      // Calculate the time difference between the current date and the next saving date
      Duration timeDifference = currentDate.difference(nextSavingDate);

      if (timeDifference.inDays >= 0) {
        // Calculate savings for this cycle and add it to the total
        totalSavings += entry.saved;

        // Move to the next saving date based on the frequency
        switch (entry.frequency) {
          case Frequency.DAILY:
            nextSavingDate = nextSavingDate.add(Duration(days: 1));
            break;
          case Frequency.WEEKLY:
            nextSavingDate = nextSavingDate.add(Duration(days: 7));
            break;
          case Frequency.MONTHLY:
            // Move to the next month, considering the actual number of days
            int nextMonth = nextSavingDate.month + 1;
            int nextYear = nextSavingDate.year;

            if (nextMonth > 12) {
              nextMonth = 1;
              nextYear++;
            }

            nextSavingDate = DateTime(nextYear, nextMonth, nextSavingDate.day);
            break;
          case Frequency.YEARLY:
            nextSavingDate = DateTime(nextSavingDate.year + 1,
                nextSavingDate.month, nextSavingDate.day);
            break;
          case Frequency.SINGLE:
            break;
        }
      }
    }

    return totalSavings;
  }
}
