import 'package:flutter/material.dart';
import '../pages/Models/medicine.dart';

class SelectedMedicinesProvider extends ChangeNotifier {
  final List<Medicine> _selectedMedicines = [];

  List<Medicine> get selectedMedicines => _selectedMedicines;

  void addMedicine(Medicine medicine) {
    if (!_selectedMedicines.contains(medicine)) {
      _selectedMedicines.add(medicine);
      notifyListeners();
    }
  }

  void removeMedicine(Medicine medicine) {
    _selectedMedicines.remove(medicine);
    notifyListeners();
  }

  void clearMedicines() {
    _selectedMedicines.clear();
    notifyListeners();
  }
}