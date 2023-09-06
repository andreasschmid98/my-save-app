import '../models/entry.dart';

class CalculatorService {

  double calculateTotalSavings(List<Entry> entries) => entries.isEmpty
      ? 0.0
      : entries
      .map((entry) => entry.saved)
      .fold(0.0, (sum, saved) => sum + saved);

  double calculateSavingStatusInPercent(List<Entry> entries, double savingGoal) {
    double totalSavings = calculateTotalSavings(entries);
    return totalSavings / savingGoal;
  }

}