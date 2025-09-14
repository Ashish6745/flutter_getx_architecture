import 'package:get/get.dart';
import 'package:mvcapp/language/english_language.dart';
import 'package:mvcapp/language/hindi_language.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "en_US": englishLanguage,
    "hi_IN": hindiLanguage,
  };
}
