import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  AuthService _authService = AuthService();

  // Sign in method
  Future<void> signIn(String username, String password) async {
    isLoading.value = true;
    var user = await _authService.signIn(username, password);
    isLoading.value = false;

    if (user != null) {
      Get.offAllNamed('/dashboard'); // Navigate to dashboard on successful login
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }

  // Check if user is logged in
  bool isAuthenticated() {
    return _authService.getCurrentUser() != null;
  }

  // Logout
  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed('/login');
  }
}
