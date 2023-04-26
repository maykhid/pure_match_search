// import 'package:flutter/material.dart';

// class MySearchDelegate extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Perform search and display results
//     return Center(
//       child: Text('Search results for $query'),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Show suggestions as the user types
//     return Center(
//       child: Text('Search suggestions for $query'),
//     );
//   }
// }