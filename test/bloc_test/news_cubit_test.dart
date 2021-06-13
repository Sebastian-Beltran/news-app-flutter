import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_architecture/src/bloc/news_cubit.dart';
import 'package:flutter_bloc_architecture/src/model/article.dart';
import 'package:flutter_bloc_architecture/src/provider/news_provider.dart';
import 'package:flutter_bloc_architecture/src/repository/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'news_cubit_test.mocks.dart';

@GenerateMocks([NewsRepositoryBase])
void main() {
  
  group('Cubit test', (){

    final article = Article(
      title: 'Test',
      author: 'Sebastian'
    );
    final mockRepo = MockNewsRepositoryBase();

    blocTest<NewsCubit, NewsState>('News will be load correctly', build: (){

      when(mockRepo.topHeadLines(any)).thenAnswer((_)async=> [article]);
      return NewsCubit(mockRepo);
    },
    act: (cubit) async => cubit.loadTopNews(),
    expect: ()=>[
      NewsLoadingState(),
      NewsLoadCompleteState([article])
    ]
    );

    blocTest<NewsCubit, NewsState>(
      'ApiKey exception is handled correctly', 
    build: (){
      when(mockRepo.topHeadLines(any)).thenAnswer((_)async=> throw ApiKeyInvalidException());
      return NewsCubit(mockRepo);
    },
    act: (cubit) async => cubit.loadTopNews(),
    expect: ()=>[
      NewsLoadingState(),
      NewsErrorState('Your API Key is invalid')
    ]
    );

  });
  

  

}