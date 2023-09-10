import 'package:background/material.dart';
import 'package:background/services/background.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ManagerH: Init------------------------
  ServiceBackground.init();
  // ManagerH: Init------------------------

  runApp(const MyApp());
}
