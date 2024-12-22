// lib/features/register/view_models/register_view_model.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:product_catalog_project/core/providers/auth_service_provider.dart';
import 'package:product_catalog_project/core/service/auth_service.dart';
import 'package:product_catalog_project/features/register/state/register_state.dart';

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, RegisterState>((ref) {
  final authService = ref.read(authServiceProvider);
  return RegisterViewModel(authService);
});

class RegisterViewModel extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterViewModel(this._authService) : super(RegisterState());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Use ValueNotifiers for error states
  final nameErrorNotifier = ValueNotifier<String?>(null);
  final emailErrorNotifier = ValueNotifier<String?>(null);
  final passwordErrorNotifier = ValueNotifier<String?>(null);

  // Validate form fields
  bool validateForm() {
    // Reset errors every time the form is validated
    nameErrorNotifier.value = null;
    emailErrorNotifier.value = null;
    passwordErrorNotifier.value = null;

    bool isValid = true;

    if (nameController.text.isEmpty) {
      nameErrorNotifier.value = 'register.full_name_required'.tr();
      isValid = false;
    }

    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      emailErrorNotifier.value = 'register.invalid_email'.tr();
      isValid = false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      passwordErrorNotifier.value = 'register.password_too_short'.tr();
      isValid = false;
    }

    return isValid;
  }

  // Perform register action after validation
  Future<void> register(BuildContext context) async {
    // Only proceed with registration if form validation is successful
    print('registering user...');
    if (validateForm()) {
      try {
        print(
            'Valid form data. Registering user... ${nameController.text}, ${emailController.text}, ${passwordController.text}');
        // Call AuthService to register the user
        await _authService.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );

        // Update state for successful registration
        state = state.copyWith(isRegistered: true);

        // Clear previous errors
        nameErrorNotifier.value = null;
        emailErrorNotifier.value = null;
        passwordErrorNotifier.value = null;
      } catch (e) {
        // Update state with error if registration fails
        nameErrorNotifier.value = 'register.registration_failed'.tr();
      }
    } else {
      state = state.copyWith(
        isRegistered: false,
      ); // Set state to false if validation fails
    }
  }
}
