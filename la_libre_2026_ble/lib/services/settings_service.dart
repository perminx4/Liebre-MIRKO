import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService with ChangeNotifier {
  final Map<String, double> _defaultSteps = {
    'kp': 10.0, 'ki': 0.01, 'kd': 1.0,
    'vm': 5.0, 've': 5.0, 'vb': 0.01, 'psup': 1.0, 'pinf': 1.0,
    'mc': 1.0, 'ab': 0.1, 'fb': 0.05, 'kf': 0.05,
  };

  late Map<String, double> _steps;
  Map<String, double> get steps => _steps;

  SettingsService() {
    _steps = Map.from(_defaultSteps);
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _steps.forEach((key, value) {
      _steps[key] = prefs.getDouble('step_$key') ?? _defaultSteps[key]!;
    });
    notifyListeners();
  }

  Future<void> saveStep(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('step_$key', value);
    _steps[key] = value;
    notifyListeners();
  }
}
