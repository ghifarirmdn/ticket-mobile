import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_mobile/repositories/auth_repository.dart';
import 'package:ticket_mobile/screens/home_screen.dart';
import 'package:ticket_mobile/screens/login_screen.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  bool isVisiblePassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void toggleVisiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  Future login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    final resp =
        await AuthRepositoryImpl().login(email: email, password: password);

    if (resp.statusCode == 200) {
      await saveToken(resp.data);
      isLoading = false;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));

      clearController();
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(resp.data["message"]),
        ),
      );
    }

    notifyListeners();
    return resp;
  }

  Future logout({
    required BuildContext context,
  }) async {
    final pref = await SharedPreferences.getInstance();

    isLoading = true;
    notifyListeners();

    final resp = await AuthRepositoryImpl().logout();

    if (resp.statusCode == 200) {
      isLoading = false;

      await pref.remove("token");
      await pref.remove("role");

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(resp.data["message"]),
        ),
      );

      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();

      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(resp.data["message"]),
        ),
      );
    }

    notifyListeners();
    return resp;
  }

  Future<bool> saveToken(data) async {
    if (data != null) {
      final pref = await SharedPreferences.getInstance();

      String accessToken = "${data['access_token']}";
      String role = "${data['user']['role']}";

      await pref.setString("token", accessToken);
      await pref.setString("role", role);
      return true;
    } else {
      log('Data is null or does not contain expected keys');
      return false;
    }
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}
