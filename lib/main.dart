import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pure_match_search/user_provider.dart';
import 'package:pure_match_search/users.dart';

void main() => runApp(const SearchTextFieldApp());

class SearchTextFieldApp extends StatelessWidget {
  const SearchTextFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const SearchTextFieldExample(),
      ),
    );
  }
}

class SearchTextFieldExample extends StatefulWidget {
  const SearchTextFieldExample({super.key});

  @override
  State<SearchTextFieldExample> createState() => _SearchTextFieldExampleState();
}

class _SearchTextFieldExampleState extends State<SearchTextFieldExample> {
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
              // // const SizedBox(
              // //   height: 50,
              // // ),
              // Text(text),
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
                        return const Center(
                            child: SizedBox(
                          child: Text(
                            'User does not exist',
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                      }

                      // users available
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
                          });
                    }

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

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.fieldValue,
  });

  final ValueChanged<String> fieldValue;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController searchController = TextEditingController();

  String text = '';

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        text = searchController.text;
      });
      if (text.isEmpty) {
        context.read<UserProvider>().getUsers(); // refresh user list if empty
      }
      context.read<UserProvider>().searchUser(text); // search on text change
    });
    super.initState();
  }

  bool showCancel = false;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size size = mediaQuery.size;
    UserProvider userProvider = context.read<UserProvider>();
    return Row(
      children: [
        SizedBox(
          width: showCancel ? size.width * 0.83 : size.width * 0.95,
          child: CupertinoSearchTextField(
            controller: searchController,
            onChanged: (String value) {
              widget.fieldValue('The text has changed to: $value');

              setState(() {
                if (value.isNotEmpty) {
                  showCancel = true;
                } else {
                  showCancel = false;
                }
              });
            },
            onSubmitted: (String value) {
              userProvider.searchUser(value);
            },
          ),
        ),
        showCancel
            ? const Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              )
            : Container()
      ],
    );
  }
}
