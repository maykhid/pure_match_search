
import 'package:flutter/material.dart';

import '../../data/model/users.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.transparent,
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.1,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.green,
            child: CircleAvatar(
              radius: 22,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Admin since 10/10/2019',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.more_horiz_outlined,
            size: 30,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
