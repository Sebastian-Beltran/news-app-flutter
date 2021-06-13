import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/navigation/routes.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsScreen extends StatelessWidget {

  static Widget create(BuildContext context){
    return BlocProvider<NewsCubit>(create: (_){

      final repository = context.read<NewsRepositoryBase>();
      return NewsCubit(repository)..loadTopNews();

    }, 
    child: NewsScreen(),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top News",
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            
          ),
        ),
        leading: Icon(Icons.fiber_new_sharp),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: Colors.black,
          size: 40.0
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state){
          if (state is NewsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is NewsErrorState){
            return Text(state.message);
          }
          final news = (state as NewsLoadCompleteState).news;
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (_, int index){
              return _ListItem(article: news[index],);
            },
          );
        },
      ),
    );
  }
}

class _ListItem extends StatelessWidget{

  final Article article;

  const _ListItem({Key? key,required this.article}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, Routes.topNewsDetails, arguments: article);
        },
        child: Card(
          elevation: 5.0,
          child: Column(
            children: [
              article.urlToImage == null ?
              Image.network("https://farm5.staticflickr.com/4363/36346283311_74018f6e7d_o.png") :
              Image.network(article.urlToImage!),
              Text(
                article.title, 
                maxLines: 1, 
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                article.description ?? 'Not Description',
                maxLines: 3,
              ),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
    );
  }

}