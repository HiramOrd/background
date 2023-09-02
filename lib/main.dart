import 'package:background/material.dart';
import 'package:background/services/background.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Manager: Init------------------------
  ServiceBackground.init();
  // Manager: Init------------------------

  runApp(const MyApp());
}
