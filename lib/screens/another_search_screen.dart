// import 'package:flutter/material.dart';

// class News {
//   final String title;
//   final String description;
//   final String author;
//   final String imageUrl;
//   final DateTime date;

//   News({
//     required this.title,
//     required this.description,
//     required this.author,
//     required this.imageUrl,
//     required this.date,
//   });
// }

// class NewsPage extends StatefulWidget {
//   const NewsPage({Key? key}) : super(key: key);

//   @override
//   _NewsPageState createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   final List<News> _newsList = [
//     News(
//       title: 'Flutter is Awesome',
//       description:
//           'Flutter is a mobile app SDK for building high-performance, high-fidelity, apps for iOS, Android, web, and desktop from a single codebase.',
//       author: 'Google',
//       imageUrl:
//           'https://flutter.dev/assets/homepage/news-2-9e6d8f6f7d6f7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d.png',
//       date: DateTime.now(),
//     ),
//     News(
//       title: 'Dart is Awesome',
//       description:
//           'Dart is a client-optimized language for fast apps on any platform. It is developed by Google and can also be used to build server-side applications.',
//       author: 'Google',
//       imageUrl: 'https://dart.dev/assets/shared/dart-logo-for-shares.png',
//       date: DateTime.now().subtract(const Duration(days: 7)),
//     ),
//     News(
//       title: 'Flutter vs React Native',
//       description:
//           'A comparison between Flutter and React Native for building cross-platform mobile apps.',
//       author: 'John Doe',
//       imageUrl: 'https://miro.medium.com/max/1200/1*JrHDbESwHvFVv8KjYqYgJw.png',
//       date: DateTime.now().subtract(const Duration(days: 15)),
//     ),
//   ];

//   List<News> _filteredNewsList = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredNewsList = _newsList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('News'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: AnotherScreen(
//                   items: _newsList,
//                   searchLabel: 'Search news',
//                   suggestion: const Center(
//                     child: Text('Filter news by date'),
//                   ),
//                   failure: const Center(
//                     child: Text('No news found :('),
//                   ),
//                   filter: (news) => [
//                     news.title,
//                     news.description,
//                     news.author,
//                   ],
//                   builder: (news) => ListTile(
//                     leading: Image.network(news.imageUrl),
//                     title: Text(news.title),
//                     subtitle: Text(news.description),
//                     trailing: Text(news.author),
//                   ),
//                 ),
//               ).then((value) {
//                 if (value != null) {
//                   setState(() {
//                     _filteredNewsList = value;
//                   });
//                 }
//               });
//             },
//             icon: const Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _filteredNewsList.length,
//         itemBuilder: (context, index) {
//           final news = _filteredNewsList[index];
//           return ListTile(
//             leading: Image.network(news.imageUrl),
//             title: Text(news.title),
//             subtitle: Text(news.description),
//             trailing: Text(news.author),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     title: const Text('Last 7 days'),
//                     onTap: () {
//                       setState(() {
//                         _filteredNewsList = _newsList
//                             .where((news) => news.date.isAfter(DateTime.now()
//                                 .subtract(const Duration(days: 7))))
//                             .toList();
//                       });
//                       Navigator.pop(context);
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Last 30 days'),
//                     onTap: () {
//                       setState(() {
//                         _filteredNewsList = _newsList
//                             .where((news) => news.date.isAfter(DateTime.now()
//                                 .subtract(const Duration(days: 30))))
//                             .toList();
//                       });
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: const Icon(Icons.filter_list),
//       ),
//     );
//   }
// }
