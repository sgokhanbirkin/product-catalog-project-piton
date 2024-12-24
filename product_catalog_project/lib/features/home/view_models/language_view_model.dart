import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageViewModelProvider =
    StateNotifierProvider<LanguageViewModel, bool>((ref) {
  return LanguageViewModel();
});

class LanguageViewModel extends StateNotifier<bool> {
  LanguageViewModel() : super(false); // Initial state is hidden (false)

  // Toggle the visibility of the language menu
  void toggleLanguageMenu() {
    state = !state; // Invert the current visibility state
  }

  // Set the visibility directly
  void setLanguageMenuVisibility(bool isVisible) {
    state = isVisible;
  }
}
