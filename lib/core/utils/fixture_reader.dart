import 'dart:io';

import 'package:flutter/services.dart';

Future<String> fixture(String name) {
  return rootBundle.loadString('lib/app/features/search/data/data_source/local/$name');
}

String fixtureTest(String name) =>
    File('lib/app/features/search/data/data_source/local/$name').readAsStringSync();
