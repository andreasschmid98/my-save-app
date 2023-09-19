import '../models/entry.dart';

class DashboardService {
  double calculateTotalSavings(List<Entry> entries) => entries.isEmpty
      ? 0.0
      : entries
          .map((entry) => entry.saved)
          .fold(0.0, (sum, saved) => sum + saved);

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
}
