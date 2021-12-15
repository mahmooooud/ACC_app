import 'package:acc_app/utils/lang/ar.dart';
import 'package:acc_app/utils/lang/en.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar,
  };
}