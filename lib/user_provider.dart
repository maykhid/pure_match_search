import 'package:flutter/material.dart';
import 'package:pure_match_search/fixture_reader.dart';

import 'users.dart';

class UserProvider extends ChangeNotifier {
  Users? _users;

  Users? get users => _users;

  getUsers() async {
    final jsonData = await fixture('users.json');

    _users = Users(users: userFromJson(jsonData));
    notifyListeners();
  }

  searchUser(String searchTerm) {
    // List<User> users = List<User>.empty();
    if (_users != null) {
      final searchResults = _users!.users.where(
          (user) => user.name.toLowerCase().contains(searchTerm.toLowerCase())).toList();

      _users = Users(users: searchResults);
      notifyListeners();
    }
  }
}
