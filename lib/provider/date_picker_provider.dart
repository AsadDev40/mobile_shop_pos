import 'package:flutter/material.dart';

class DatePickerProvider extends ChangeNotifier {
  DateTime _currentDate = DateTime.now();
  int _selectedDate = -1;

  DateTime get currentDate => _currentDate;
  int get selectedDate => _selectedDate;

  void updateMonth(int change) {
    _currentDate = DateTime(_currentDate.year, _currentDate.month + change);
    notifyListeners();
  }

  void selectDate(int day) {
    _selectedDate = day;
    notifyListeners();
  }

  List<int> generateDaysForMonth() {
    final lastDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0);
    return List<int>.generate(lastDayOfMonth.day, (i) => i + 1);
  }

  int get startWeekday =>
      DateTime(_currentDate.year, _currentDate.month, 1).weekday;
}
