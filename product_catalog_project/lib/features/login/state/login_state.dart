// lib/features/auth/state/login_state.dart

class LoginState {
  final bool isLoggedIn;
  final bool rememberMe;
  final String? emailError;
  final String? passwordError;

  LoginState({
    this.isLoggedIn = false,
    this.rememberMe = false,
    this.emailError,
    this.passwordError,
  });

  // Copy with method to update state easily
  LoginState copyWith({
    bool? isLoggedIn,
    bool? rememberMe,
    String? emailError,
    String? passwordError,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      rememberMe: rememberMe ?? this.rememberMe,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
