import 'package:flutter/material.dart';

class NoUsersFound extends StatelessWidget {
  const NoUsersFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      child: Text(
        'User does not exist',
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}
