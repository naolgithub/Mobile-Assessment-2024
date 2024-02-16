import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/services/api_service.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //Write your code here
//     return Scaffold(

//     );
//   }
// }

class SearchScreen extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Define how search results are displayed
    return FutureBuilder(
      future: APIService().fetchSearch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error searching news'),
          );
        }
        if (snapshot.hasData) {
          final _articles = snapshot.data;
          if (_articles!.length < 1) {
            return Center(
              child: Text("No results found!"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => Card(
              child: Row(
                children: [
                  Image.network(
                    _articles![index].urlToImage,
                    height: 100,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(_articles[index].title, maxLines: 1),
                      Text('Author: ${_articles[index].author}', maxLines: 1),
                      Text(_articles[index].description, maxLines: 2),
                    ],
                  ))
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: APIService().fetchSearch(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          debugPrint(snapshot.data.toString());
          return const Center(
            child: Text('Error searching news'),
          );
        }
        if (snapshot.hasData) {
          final _articles = snapshot.data;
          if (_articles!.isEmpty) {
            return const Center(
              child: Text("No results found!"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(_articles[index].title),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
