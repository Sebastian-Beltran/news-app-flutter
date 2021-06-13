import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';

class NewsCubit extends Cubit<NewsState>{

  final NewsRepositoryBase _repository;

  NewsCubit(this._repository) : super(NewsInitalState());

  Future<void> loadTopNews({String country = 'us'}) async{
    try {
      emit(NewsLoadingState());

      final news = await _repository.topHeadLines(country);

      emit(NewsLoadCompleteState(news));
      
    }on Exception catch (e){
      if (e is MissingApiKeyException) {
        emit(NewsErrorState('Please, Check your API Key'));
      }else if(e is ApiKeyInvalidException){
        emit(NewsErrorState('Your API Key is invalid'));
      }else{
        emit(NewsErrorState('Unkwon error, try again!'));
      }
    }


  }
}

abstract class NewsState extends Equatable{
  @override
  List<Object> get props => [];
}

class NewsInitalState extends NewsState{}

class NewsLoadingState extends NewsState{}

class NewsLoadCompleteState extends NewsState{
  final List<Article> news;

  NewsLoadCompleteState(this.news);

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState{
  final String message;

  NewsErrorState(this.message);
  @override
  List<Object> get props => [message];
}