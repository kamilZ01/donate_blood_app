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

  /// `Donate`
  String get donate {
    return Intl.message(
      'Donate',
      name: 'donate',
      desc: '',
      args: [],
    );
  }

  /// `Blood`
  String get blood {
    return Intl.message(
      'Blood',
      name: 'blood',
      desc: '',
      args: [],
    );
  }

  /// `Save lives`
  String get saveLives {
    return Intl.message(
      'Save lives',
      name: 'saveLives',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `FORGET PASSWORD`
  String get forgetPassword {
    return Intl.message(
      'FORGET PASSWORD',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `The passwords entered are different.`
  String get differentPassword {
    return Intl.message(
      'The passwords entered are different.',
      name: 'differentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPasswordAsk {
    return Intl.message(
      'Forget password?',
      name: 'forgetPasswordAsk',
      desc: '',
      args: [],
    );
  }

  /// `Check the mailbox`
  String get openEmailApp {
    return Intl.message(
      'Check the mailbox',
      name: 'openEmailApp',
      desc: '',
      args: [],
    );
  }

  /// `No mail apps installed`
  String get noMailApp {
    return Intl.message(
      'No mail apps installed',
      name: 'noMailApp',
      desc: '',
      args: [],
    );
  }

  /// `Your email`
  String get email {
    return Intl.message(
      'Your email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be empty`
  String get passwordEmpty {
    return Intl.message(
      'Password can\'t be empty',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `{title} can't be empty`
  String inputEmpty(Object title) {
    return Intl.message(
      '$title can\'t be empty',
      name: 'inputEmpty',
      desc: '',
      args: [title],
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

  /// `Dismiss`
  String get dismiss {
    return Intl.message(
      'Dismiss',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account`
  String get verifyEmailDialogTitle {
    return Intl.message(
      'Verify your account',
      name: 'verifyEmailDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Link to verify account has been sent to your email`
  String get verifyEmailDialogContent {
    return Intl.message(
      'Link to verify account has been sent to your email',
      name: 'verifyEmailDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password`
  String get passwordResetEmailDialogTitle {
    return Intl.message(
      'Forgot your password',
      name: 'passwordResetEmailDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you a reset password link on your registered email address`
  String get passwordResetEmailDialogContent {
    return Intl.message(
      'We have sent you a reset password link on your registered email address',
      name: 'passwordResetEmailDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `The user corresponding to the given email has been disabled.`
  String get userDisabled {
    return Intl.message(
      'The user corresponding to the given email has been disabled.',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get invalidEmail {
    return Intl.message(
      'The email address is not valid.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `There was an undefined login problem. Error: {error}`
  String loginError(Object error) {
    return Intl.message(
      'There was an undefined login problem. Error: $error',
      name: 'loginError',
      desc: '',
      args: [error],
    );
  }

  /// `There was an undefined register problem. Error: {error}`
  String registerError(Object error) {
    return Intl.message(
      'There was an undefined register problem. Error: $error',
      name: 'registerError',
      desc: '',
      args: [error],
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

  /// `The operation not allowed.`
  String get operationNotAllowed {
    return Intl.message(
      'The operation not allowed.',
      name: 'operationNotAllowed',
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

  /// `Please choose one`
  String get pleaseChooseOne {
    return Intl.message(
      'Please choose one',
      name: 'pleaseChooseOne',
      desc: '',
      args: [],
    );
  }

  /// `Please enter {value}`
  String pleaseEnterValue(Object value) {
    return Intl.message(
      'Please enter $value',
      name: 'pleaseEnterValue',
      desc: '',
      args: [value],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Blood type`
  String get bloodType {
    return Intl.message(
      'Blood type',
      name: 'bloodType',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Recent donations`
  String get recentDonations {
    return Intl.message(
      'Recent donations',
      name: 'recentDonations',
      desc: '',
      args: [],
    );
  }

  /// `Your badges`
  String get yourBadges {
    return Intl.message(
      'Your badges',
      name: 'yourBadges',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Enter Some Text`
  String get enterSomeText {
    return Intl.message(
      'Enter Some Text',
      name: 'enterSomeText',
      desc: '',
      args: [],
    );
  }

  /// `Donor`
  String get donor {
    return Intl.message(
      'Donor',
      name: 'donor',
      desc: '',
      args: [],
    );
  }

  /// `Collections`
  String get collections {
    return Intl.message(
      'Collections',
      name: 'collections',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Recent collections`
  String get recentCollections {
    return Intl.message(
      'Recent collections',
      name: 'recentCollections',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
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