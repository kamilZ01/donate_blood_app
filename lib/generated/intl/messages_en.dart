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

  static m0(error) => "Email can\'t be changed. Error: ${error}";

  static m1(error) => "Password can\'t be changed. Error: ${error}";

  static m2(error) => "User can\'t be delete. Error: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appTitle" : MessageLookupByLibrary.simpleMessage("Donate Blood"),
    "changedEmail" : MessageLookupByLibrary.simpleMessage("Successful changed email"),
    "changedPassword" : MessageLookupByLibrary.simpleMessage("Successful changed password"),
    "emailAlreadyUser" : MessageLookupByLibrary.simpleMessage("The account already exists for that email."),
    "loginError" : MessageLookupByLibrary.simpleMessage("There was an undefined login problem."),
    "notChangedEmail" : m0,
    "notChangedPassword" : m1,
    "notUserDeleted" : m2,
    "userDeleted" : MessageLookupByLibrary.simpleMessage("Successful user deleted."),
    "userDisabled" : MessageLookupByLibrary.simpleMessage("The user corresponding to the given email has been disabled"),
    "userNotFound" : MessageLookupByLibrary.simpleMessage("No user found for that email."),
    "weakPassword" : MessageLookupByLibrary.simpleMessage("The password provided is too weak."),
    "wrongPassword" : MessageLookupByLibrary.simpleMessage("Wrong password provided for that user.")
  };
}
