import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_mobile/core/constants/colors.dart';
import 'package:ticket_mobile/core/widgets/button_widget.dart';
import 'package:ticket_mobile/core/widgets/loading_widget.dart';
import 'package:ticket_mobile/core/widgets/textfield_widget.dart';
import 'package:ticket_mobile/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Ticket App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              TextfieldWidget(
                hintText: "Enter your email",
                controller: authProvider.emailController,
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 24),
              TextfieldWidget(
                hintText: "Enter your password",
                controller: authProvider.passwordController,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                obscureText: !authProvider.isVisiblePassword,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey[400],
                ),
                suffixIcon: GestureDetector(
                  onTap: () => authProvider.toggleVisiblePassword(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22),
                    child: authProvider.isVisiblePassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ButtonWidget(
                bgColor: primaryColor,
                borderColor: Colors.transparent,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    authProvider.login(
                      email: authProvider.emailController.text,
                      password: authProvider.passwordController.text,
                      context: context,
                    );
                  }
                },
                child: authProvider.isLoading
                    ? const LoadingWidget()
                    : Text(
                        "Masuk",
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
