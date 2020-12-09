// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(title) => "${title} can\'t be empty";

  static m1(error) => "There was an undefined login problem. Error: ${error}";

  static m2(error) => "Email can\'t be changed. Error: ${error}";

  static m3(error) => "Password can\'t be changed. Error: ${error}";

  static m4(error) => "User can\'t be delete. Error: ${error}";

  static m5(value) => "Please enter ${value}";

  static m6(error) => "There was an undefined register problem. Error: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "amount" : MessageLookupByLibrary.simpleMessage("Amount"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("Donate Blood"),
    "blood" : MessageLookupByLibrary.simpleMessage("Blood"),
    "bloodType" : MessageLookupByLibrary.simpleMessage("Blood type"),
    "changedEmail" : MessageLookupByLibrary.simpleMessage("Successful changed email"),
    "changedPassword" : MessageLookupByLibrary.simpleMessage("Successful changed password"),
    "collections" : MessageLookupByLibrary.simpleMessage("Collections"),
    "confirmPassword" : MessageLookupByLibrary.simpleMessage("Confirm password"),
    "date" : MessageLookupByLibrary.simpleMessage("Date"),
    "differentPassword" : MessageLookupByLibrary.simpleMessage("The passwords entered are different."),
    "dismiss" : MessageLookupByLibrary.simpleMessage("Dismiss"),
    "donate" : MessageLookupByLibrary.simpleMessage("Donate"),
    "donor" : MessageLookupByLibrary.simpleMessage("Donor"),
    "editProfile" : MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email" : MessageLookupByLibrary.simpleMessage("Your email"),
    "emailAlreadyUser" : MessageLookupByLibrary.simpleMessage("The account already exists for that email."),
    "enterSomeText" : MessageLookupByLibrary.simpleMessage("Enter Some Text"),
    "forgetPassword" : MessageLookupByLibrary.simpleMessage("FORGET PASSWORD"),
    "forgetPasswordAsk" : MessageLookupByLibrary.simpleMessage("Forget password?"),
    "fullName" : MessageLookupByLibrary.simpleMessage("Full Name"),
    "inputEmpty" : m0,
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("The email address is not valid."),
    "loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "loginError" : m1,
    "noMailApp" : MessageLookupByLibrary.simpleMessage("No mail apps installed"),
    "notChangedEmail" : m2,
    "notChangedPassword" : m3,
    "notUserDeleted" : m4,
    "openEmailApp" : MessageLookupByLibrary.simpleMessage("Check the mailbox"),
    "operationNotAllowed" : MessageLookupByLibrary.simpleMessage("The operation not allowed."),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "passwordEmpty" : MessageLookupByLibrary.simpleMessage("Password can\'t be empty"),
    "passwordResetEmailDialogContent" : MessageLookupByLibrary.simpleMessage("We have sent you a reset password link on your registered email address"),
    "passwordResetEmailDialogTitle" : MessageLookupByLibrary.simpleMessage("Forgot your password"),
    "phone" : MessageLookupByLibrary.simpleMessage("Phone"),
    "pleaseChooseOne" : MessageLookupByLibrary.simpleMessage("Please choose one"),
    "pleaseEnterValue" : m5,
    "readMore" : MessageLookupByLibrary.simpleMessage("Read more"),
    "recentCollections" : MessageLookupByLibrary.simpleMessage("Recent collections"),
    "recentDonations" : MessageLookupByLibrary.simpleMessage("Recent donations"),
    "registerError" : m6,
    "saveLives" : MessageLookupByLibrary.simpleMessage("Save lives"),
    "signUp" : MessageLookupByLibrary.simpleMessage("Sign Up"),
    "somethingWentWrong" : MessageLookupByLibrary.simpleMessage("Something went wrong"),
    "userDeleted" : MessageLookupByLibrary.simpleMessage("Successful user deleted."),
    "userDisabled" : MessageLookupByLibrary.simpleMessage("The user corresponding to the given email has been disabled."),
    "userNotFound" : MessageLookupByLibrary.simpleMessage("No user found for that email."),
    "verifyEmailDialogContent" : MessageLookupByLibrary.simpleMessage("Link to verify account has been sent to your email"),
    "verifyEmailDialogTitle" : MessageLookupByLibrary.simpleMessage("Verify your account"),
    "weakPassword" : MessageLookupByLibrary.simpleMessage("The password provided is too weak."),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome"),
    "wrongPassword" : MessageLookupByLibrary.simpleMessage("Wrong password provided for that user."),
    "yourBadges" : MessageLookupByLibrary.simpleMessage("Your badges")
  };
}
