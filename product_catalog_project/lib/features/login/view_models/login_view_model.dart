// lib/features/auth/view_models/login_view_model.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:product_catalog_project/core/providers/auth_service_provider.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';
import 'package:product_catalog_project/features/login/state/login_state.dart';

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  // Get AuthService using the provider
  final authService = ref.read(authServiceProvider);
  return LoginViewModel(authService);
});

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthService _authService;

  LoginViewModel(this._authService) : super(LoginState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Use ValueNotifiers for error states
  final emailErrorNotifier = ValueNotifier<String?>(null);
  final passwordErrorNotifier = ValueNotifier<String?>(null);

  // Validate form fields
  bool validateForm() {
    // Reset errors every time the form is validated
    emailErrorNotifier.value = null;
    passwordErrorNotifier.value = null;

    bool isValid = true;

    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      emailErrorNotifier.value = 'login.wrong_email_format'.tr();
      isValid = false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      passwordErrorNotifier.value = 'login.wrong_password'.tr();
      isValid = false;
    }

    return isValid;
  }

  // Perform login action after validation
  Future<void> login(BuildContext context) async {
    // Only proceed with login if form validation is successful
    if (validateForm()) {
      try {
        // Call AuthService to log the user in
        await _authService.login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );

        // Update state for successful login
        state = state.copyWith(isLoggedIn: true);

        // Clear previous errors
        emailErrorNotifier.value = null;
        passwordErrorNotifier.value = null;
      } catch (e) {
        // Update state with error if login fails

        passwordErrorNotifier.value = 'login.invalid_credentials'.tr();
      }
    } else {
      state = state.copyWith(
        isLoggedIn: false,
      ); // Set state to false if validation fails
    }
  }

  // Toggle the rememberMe state
  void toggleRememberMe(bool? value) {
    state = state.copyWith(rememberMe: value ?? false);
  }
}
