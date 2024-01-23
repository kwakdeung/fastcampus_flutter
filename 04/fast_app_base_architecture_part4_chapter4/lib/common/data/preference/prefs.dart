import 'package:fast_app_base_architecture/common/data/preference/item/nullable_preference_item.dart';
import 'package:fast_app_base_architecture/common/theme/custom_theme.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
}
