enum LanguageEnum {
  english,
  french;

  static LanguageEnum fromString(String language) {
    if (language == LanguageEnum.english.languageText) {
      return LanguageEnum.english;
    } else if (language == LanguageEnum.french.languageText) {
      return LanguageEnum.french;
    } else {
      return LanguageEnum.english;
    }
  }

  static LanguageEnum fromCode(String languageCode) {
    if (languageCode == LanguageEnum.english.code) {
      return LanguageEnum.english;
    } else if (languageCode == LanguageEnum.french.code) {
      return LanguageEnum.french;
    } else {
      return LanguageEnum.english;
    }
  }

  String get code {
    switch (this) {
      case LanguageEnum.english:
        return "en";
      case LanguageEnum.french:
        return "fr";
    }
  }

  String get languageText {
    switch (this) {
      case LanguageEnum.english:
        return "English";
      case LanguageEnum.french:
        return "French";
    }
  }

  bool get isRTL {
    switch (this) {
      case LanguageEnum.french:
      case LanguageEnum.english:
        return false;
    }
  }
}
