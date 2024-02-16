import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_app/models/new_model.dart';
import 'package:flutter_news_app/screens/home_screen.dart';
import 'package:flutter_news_app/screens/new_detail_page.dart';
import 'package:flutter_news_app/widgets/home/all_news.dart';
import 'package:flutter_news_app/widgets/home/tab_item.dart';

import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NewModel newModel = NewModel(
      title: "title",
      author: 'author',
      urlToImage: 'urlToImage',
      publishedAt: 'publishedAt',
      url: 'url',
      description: 'description',
      content: 'This is content');

  final ScrollController _listViewController = ScrollController();
  int currentPageIndex = 1;

  final TextEditingController _serchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Write your code here
    return FutureBuilder(
        future: APIService().fetchAll(page: currentPageIndex),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _serchBarController,
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text("Serach "))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    NewModel newModel = snapshot.data![index];
                    return SearchCard(newModel: newModel);
                  },
                ),
              ],
            ),
          ));
        });
  }
}

class SearchCard extends StatelessWidget {
  SearchCard({super.key, required this.newModel});
  NewModel newModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewDetailPage(
                  newModel: newModel,
                )));
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: showLine(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: showLine(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      newModel.urlToImage,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) => Container(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            newModel.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            newModel.author,
                            maxLines: 1,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.link),
                                Text(newModel.publishedAt)
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
