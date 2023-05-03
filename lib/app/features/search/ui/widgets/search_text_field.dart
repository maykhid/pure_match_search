import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

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
