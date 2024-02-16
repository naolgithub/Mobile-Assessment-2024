// import 'package:flutter/material.dart';

// void _showFilteredNewsDataDialog() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Select Filter'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: _newsDataFilters
//                 .map(
//                   (filter) => ListTile(
//                     title: Text(filter['title']),
//                     onTap: () {
//                       setState(() {
//                         _selectedFilter = filter;
//                       });
//                       Navigator.pop(context);
//                     },
//                     selected: _selectedFilter == filter,
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       );
//     },
//   );
// }
