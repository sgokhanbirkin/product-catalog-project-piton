import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateProvider<String>((ref) {
  return 'en'; // default language
});
