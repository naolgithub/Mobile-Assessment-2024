import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/services/api_service.dart';
import 'package:flutter_news_app/widgets/home/all_news.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<NewModel> _searchResults = [];
  bool _searchTriggered = false;
  bool _loadingMore = false;

  Map<String, dynamic>? _selectedFilter;
  int _currentPage = 1;

  final APIService _apiService = APIService();
  final List<Map<String, dynamic>> _newsDataFilters = [
    {'title': 'Last 30 days', 'duration': const Duration(days: 30)},
    {'title': 'Last 7 days', 'duration': const Duration(days: 7)},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilteredNewsDataDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'keywords to search...',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _searchResults.clear();
              _currentPage = 1;
              _searchNews();
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: _searchTriggered
                ? _searchResults.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!_loadingMore &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _loadMore();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount:
                              _searchResults.length + (_loadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < _searchResults.length) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: HomeNewItem(
                                    newModel: _searchResults[index],
                                  ));
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                : Container(),
          ),
        ],
      ),
    );
  }

  void _searchNews() async {
    setState(() {
      _searchResults.clear();
      _searchTriggered = true;
    });

    try {
      List<NewModel> searchResults = await _apiService.searchNews(
        _searchController.text,
        duration: _selectedFilter?['duration'],
        page: _currentPage,
      );
      setState(() {
        _searchResults.addAll(searchResults);
      });
    } catch (e) {
      print('Error searching news: $e');
      // Handle error - Display an error message to the user
    }
  }

  void _loadMore() async {
    setState(() {
      _loadingMore = true;
    });

    try {
      _currentPage++;
      List<NewModel> moreResults = await _apiService.searchNews(
        _searchController.text,
        duration: _selectedFilter?['duration'],
        page: _currentPage,
      );
      setState(() {
        _searchResults.addAll(moreResults);
        _loadingMore = false;
      });
    } catch (e) {
      debugPrint('Error loading news: $e');
      setState(() {
        _loadingMore = false;
      });
    }
  }

  void _showFilteredNewsDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Filtered news data'),
          content: SingleChildScrollView(
            child: Column(
              children: _newsDataFilters
                  .map(
                    (filter) => ListTile(
                      title: Text(filter['title']),
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                        Navigator.pop(context);
                      },
                      selected: _selectedFilter == filter,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
