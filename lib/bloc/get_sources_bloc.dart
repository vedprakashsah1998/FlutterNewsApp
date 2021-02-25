import 'package:flutter/cupertino.dart';
import 'package:news_app/model/source_response.dart';
import 'package:news_app/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceBloc{
  final NewsRepository _respository = NewsRepository();

  final BehaviorSubject<SourceResponse> _subject =
  BehaviorSubject<SourceResponse>();

  getSources() async {
    SourceResponse response = await _respository.getSources();
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
  BehaviorSubject<SourceResponse> get subject => _subject;


}
final getSourceBloc = GetSourceBloc();
