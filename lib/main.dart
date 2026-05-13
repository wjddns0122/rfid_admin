import 'package:admin_rfid/screens/staff_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin RFID',
      theme: AppTheme.lightTheme,
      home: const StaffDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
