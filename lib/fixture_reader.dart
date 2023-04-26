import 'dart:io';

import 'package:flutter/services.dart';

Future<String> fixture(String name) {
  return rootBundle.loadString('lib/$name');
}

String fixtureTest(String name) =>
    File('lib/$name').readAsStringSync();
