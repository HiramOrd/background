import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

// Manager: Background service ------------------------
class ServiceBackground {
  static init() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    Workmanager().registerPeriodicTask(
      "periodic-task-identifier",
      "simplePeriodicTask",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  // Setup background task-----------------
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      int? totalExecutions;
      final sharedPreference = await SharedPreferences.getInstance();

      try {
        totalExecutions = sharedPreference.getInt("totalExecutions");
        sharedPreference.setInt("totalExecutions", totalExecutions == null ? 1 : totalExecutions + 1);

        print(totalExecutions);
      } catch (err) {
        Logger().e(err.toString());
        throw Exception(err);
      }

      return Future.value(true);
    });
  }
}
