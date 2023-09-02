import 'package:background/material.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  // Manager: Init ------------------------

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    frequency: const Duration(seconds: 5),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  // Manager: Init ------------------------

  runApp(const MyApp());
}

// Background
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    int? totalExecutions;
    final sharedPreference = await SharedPreferences.getInstance();

    try {
      totalExecutions = sharedPreference.getInt("totalExecutions");
      sharedPreference.setInt("totalExecutions", totalExecutions == null ? 1 : totalExecutions + 1);
    } catch (err) {
      Logger().e(err.toString());
      throw Exception(err);
    }

    return Future.value(true);
  });
}
