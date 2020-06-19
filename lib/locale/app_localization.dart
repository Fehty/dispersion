import 'package:dispersion/l10n/messages_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get appName => Intl.message('App name', name: 'appName');

  String get whiteLight => Intl.message('White light', name: 'whiteLight');

  String get fullWhiteLight =>
      Intl.message('White light', name: 'fullWhiteLight');

  String get monoLight => Intl.message('Monochromatic', name: 'monoLight');

  String get fullMonoLight => Intl.message('Monochrome', name: 'fullMonoLight');

  String get info => Intl.message('Information', name: 'info');

  String get infoText => Intl.message('infoText', name: 'infoText');

  String get exit => Intl.message('Exit', name: 'exit');

  String get nm => Intl.message('nm', name: 'nm');
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['ru', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
