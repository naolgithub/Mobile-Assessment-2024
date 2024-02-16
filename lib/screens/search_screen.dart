import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/another_search_screen.dart';
import 'package:flutter_news_app/services/api_service.dart';

class SearchScreen extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          const NewsPage();
        }
        icon: const Icon(Icons.clear),
      ),
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
          final articles = snapshot.data;
          if (articles!.isEmpty) {
            return const Center(
              child: Text("No results found!"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => Card(
              child: Row(
                children: [
                  Image.network(
                    articles[index].urlToImage,
                    height: 100,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Text(articles[index].title, maxLines: 1),
                      Text('Author: ${articles[index].author}', maxLines: 1),
                      Text(articles[index].description, maxLines: 2),
                    ],
                  ))
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
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
          final articles = snapshot.data;
          if (articles!.isEmpty) {
            return const Center(
              child: Text("No results found!"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(articles[index].title),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
