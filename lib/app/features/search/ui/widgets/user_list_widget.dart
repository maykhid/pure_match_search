import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'user_list_item.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return ListView.separated(
          itemCount: userProvider.users?.users.length as int,
          separatorBuilder: (context, count) {
            return Container(
              color: Colors.black,
              width: 200,
              height: 5,
            );
          },
          itemBuilder: (context, count) {
            return UserListItem(
              user: userProvider.users!.users[count],
            );
          },
        );
      },
    );
  }
}
