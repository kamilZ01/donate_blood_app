// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Donate Blood`
  String get appTitle {
    return Intl.message(
      'Donate Blood',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get userNotFound {
    return Intl.message(
      'No user found for that email.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get wrongPassword {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `The user corresponding to the given email has been disabled`
  String get userDisabled {
    return Intl.message(
      'The user corresponding to the given email has been disabled',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `There was an undefined login problem.`
  String get loginError {
    return Intl.message(
      'There was an undefined login problem.',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailAlreadyUser {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailAlreadyUser',
      desc: '',
      args: [],
    );
  }

  /// `Successful changed email`
  String get changedEmail {
    return Intl.message(
      'Successful changed email',
      name: 'changedEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email can't be changed. Error: {error}`
  String notChangedEmail(Object error) {
    return Intl.message(
      'Email can\'t be changed. Error: $error',
      name: 'notChangedEmail',
      desc: '',
      args: [error],
    );
  }

  /// `Successful changed password`
  String get changedPassword {
    return Intl.message(
      'Successful changed password',
      name: 'changedPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be changed. Error: {error}`
  String notChangedPassword(Object error) {
    return Intl.message(
      'Password can\'t be changed. Error: $error',
      name: 'notChangedPassword',
      desc: '',
      args: [error],
    );
  }

  /// `Successful user deleted.`
  String get userDeleted {
    return Intl.message(
      'Successful user deleted.',
      name: 'userDeleted',
      desc: '',
      args: [],
    );
  }

  /// `User can't be delete. Error: {error}`
  String notUserDeleted(Object error) {
    return Intl.message(
      'User can\'t be delete. Error: $error',
      name: 'notUserDeleted',
      desc: '',
      args: [error],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}