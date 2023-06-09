import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/no_users_found.dart';
import '../widgets/search_text_field.dart';
import '../widgets/user_list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String text = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      WidgetsFlutterBinding.ensureInitialized();
      context.read<UserProvider>().getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Manage Admins',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        trailing: Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SearchTextField(
                fieldValue: (String value) {
                  setState(() {
                    text = value;
                  });
                },
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.79,
                width: mediaQuery.size.width,
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, _) {
                    if (userProvider.users?.users != null) {
                      // user not found
                      if (userProvider.users!.users.isEmpty) {
                        return const NoUsersFound();
                      }

                      // users available
                      return const UserListWidget();
                    }

                    // return empty list
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
