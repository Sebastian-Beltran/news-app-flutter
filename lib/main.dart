import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/navigation/routes.dart';
import 'package:flutter_bloc_architecture/src/provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/repository/implementation/news_repository.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:flutter_bloc_architecture/src/ui/news_screen.dart';

void main() {

  final newsProvider = NewsProvider();
  final newsRepository = NewsRepository(newsProvider);

  runApp(
    RepositoryProvider<NewsRepositoryBase>(
      create: (_) => newsRepository,
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => Routes.routes(settings),
     
    );
  }
}

