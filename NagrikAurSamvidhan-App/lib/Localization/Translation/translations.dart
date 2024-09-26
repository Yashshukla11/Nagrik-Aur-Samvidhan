import 'package:get/get.dart';
import '../Language/en_us.dart';
import '../Language/gu_in.dart';
import '../Language/hi_in.dart';
import '../Language/bn_in.dart';
import '../Language/ta_in.dart';
import '../Language/te_in.dart';
import '../Language/mr_in.dart';
import '../Language/kn_in.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'gu_IN': guIn,
        'hi_IN': hiIn,
        'bn_IN': bnIn,
        'ta_IN': taIn,
        'te_IN': teIn,
        'mr_IN': mrIn,
        'kn_IN': knIn,
      };
}

final List<LanguageModel> languages = [
  LanguageModel('English', 'en_US'),
  LanguageModel('ગુજરાતી', 'gu_IN'),
  LanguageModel('हिन्दी', 'hi_IN'),
  LanguageModel('বাংলা', 'bn_IN'),
  LanguageModel('தமிழ்', 'ta_IN'),
  LanguageModel('తెలుగు', 'te_IN'),
  LanguageModel('मराठी', 'mr_IN'),
  LanguageModel('ಕನ್ನಡ', 'kn_IN'),
];

class LanguageModel {
  LanguageModel(this.language, this.languageCode);

  final String language;
  final String languageCode;
}
