import 'package:background/home_widget.dart';
import 'package:background/home_widget_default.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

// ManagerH: Usefull functions ------------------------

Future<void> _updateWidget(int totalExecutions) async {
  const appGroupId = 'MyAppName';
  const iOSWidgetName = 'NewAppWidget';
  const androidWidgetName = 'NewAppWidget';

  await HomeWidget.setAppGroupId(appGroupId);

  await HomeWidget.renderFlutterWidget(
    WHomeHideget(index: totalExecutions),
    key: 'filename',
    logicalSize: const Size(100, 100),
    pixelRatio: 1,
  );

  await HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
    androidName: androidWidgetName,
  );
}

void _defaultWidget() async {
  const appGroupId = 'MyAppName';
  const iOSWidgetName = 'NewAppWidget';
  const androidWidgetName = 'NewAppWidget';

  await HomeWidget.setAppGroupId(appGroupId);

  await HomeWidget.renderFlutterWidget(
    const WHomeHidegetDefault(),
    key: 'filename',
    logicalSize: const Size(100, 100),
    pixelRatio: 1,
  );

  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
    androidName: androidWidgetName,
  );
}

@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      int? totalExecutions;

      final sharedPreference = await SharedPreferences.getInstance();
      totalExecutions = sharedPreference.getInt("totalExecutions") ?? 1;

      await _updateWidget(totalExecutions);

      await sharedPreference.setInt("totalExecutions", totalExecutions + 1);
    } catch (err) {
      Logger().e(err.toString());
      throw Exception(err);
    }

    return Future.value(true);
  });
}

// ManagerH: Background service ------------------------
class ServiceBackground {
  static init() {
    Workmanager().cancelAll();
    Workmanager().initialize(
      _callbackDispatcher,
      isInDebugMode: true,
    );
    Workmanager().registerPeriodicTask(
      "task-identifier",
      "simpleTask",
      initialDelay: const Duration(seconds: 10),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );

    _defaultWidget();
  }
}
