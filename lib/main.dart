import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pure_match_search/app/features/search/ui/providers/user_provider.dart';

import 'app/features/search/ui/screens/search_screen.dart';

void main() => runApp(const SearchTextFieldApp());

class SearchTextFieldApp extends StatelessWidget {
  const SearchTextFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.dark),
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const SearchScreen(),
      ),
    );
  }
}
