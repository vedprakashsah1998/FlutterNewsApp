import 'package:flutter/cupertino.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceNewsBloc{
  final NewsRepository _respository = NewsRepository();

  final BehaviorSubject<ArticleResponse> _subject =
  BehaviorSubject<ArticleResponse>();

  getSourceNews(String sourceId) async {
    ArticleResponse response = await _respository.getSourceNews(sourceId);
    _subject.sink.add(response);
  }

  void drainStream(){
    _subject.value=null;
  }


  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }
}