// lib/features/register/state/register_state.dart

class RegisterState {
  final bool isRegistered;
  final String? nameError;
  final String? emailError;
  final String? passwordError;

  RegisterState({
    this.isRegistered = false,
    this.nameError,
    this.emailError,
    this.passwordError,
  });

  RegisterState copyWith({
    bool? isRegistered,
    String? nameError,
    String? emailError,
    String? passwordError,
  }) {
    return RegisterState(
      isRegistered: isRegistered ?? this.isRegistered,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
