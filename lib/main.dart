import 'package:blood_donor_dashboard/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/admin_dashboard_screen.dart';
import 'views/login_screen.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true, // Enable Material 3 design

      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true
      ),
      initialRoute: authController.isAuthenticated() ? '/dashboard' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/dashboard', page: () => AdminDashboardScreen()),
      ],
    );
  }
}
