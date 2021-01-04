import 'package:donate_blood/generated/l10n.dart';

class DonationType {
  String getTranslationOfBlood(String text) {
    if (text.trim() == 'Whole blood' || text.trim() == 'Krew pełna') {
      return S.current.wholeBlood;
    } else if (text.trim() == 'Plasma' || text.trim() == 'Osocze') {
      return S.current.plasma;
    } else if (text.trim() == 'Platelets' || text.trim() == 'Płytki krwi') {
      return S.current.platelets;
    } else
      return "N/A";
  }
}
