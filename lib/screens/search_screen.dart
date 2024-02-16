import 'package:dio/dio.dart'; // Use this for network requests
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart'; // Make sure this is defined

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Dio dio = Dio();

  String searchQuery = '';
  List<NewModel> articles = [];
  String errorMessage = '';

  Future<void> fetchNews({String? searchQuery}) async {
    try {
      final response = await dio.get(
        "/everything",
        queryParameters: {
          "q": searchQuery ??
              "", // Use the searchQuery if provided, or "" as default
          "page": 1, // Start from page 1 by default
        },
      );

      if (response.statusCode == 200) {
        final json = response.data;

        // Handle potential errors in the API response
        if (json['status'] != 'ok' || json['articles'] == null) {
          throw Exception('Error: ${json['message']}');
        }

        setState(() {
          articles = (json['articles'] as List)
              .map((article) => NewModel.fromJson(article))
              .toList();
        });
      }
    } catch (error) {
      errorMessage = 'Error: $error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search news...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
                fetchNews(searchQuery: searchQuery);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.title ??
                      ''), // Handle cases where title might be null
                  subtitle: Text(article.description ?? ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
