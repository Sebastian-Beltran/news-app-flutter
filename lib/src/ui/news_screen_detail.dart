import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';

class NewsDetailsScreen extends StatelessWidget {

  static Widget create(Object article) => NewsDetailsScreen(article: article as Article);

  final Article article;

  const NewsDetailsScreen({Key? key,required this.article}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: Colors.black,
          size: 40.0
        ),
      ),
      body: Column(
        children: [
          article.urlToImage == null ?
          Image.network("https://farm5.staticflickr.com/4363/36346283311_74018f6e7d_o.png") :
          Image.network(article.urlToImage!),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
            child: Text(
              article.description ?? 'Not Description',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}