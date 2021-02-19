import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_hotnews_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/model/article_response.dart';
import 'package:news_app/style/theme.dart';
import 'package:timeago/timeago.dart' as timeago;


class HotNews extends StatefulWidget {
  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotNewsBloc.getHotNews();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getHotNewsBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildHotNews(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildHotNews(ArticleResponse data) {
    List<ArticleModel> article = data.articles;

    if (article.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("No Sources")],
        ),
      );
    } else {
      return Container(
        child: GridView.builder(
            itemCount: article.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                // childAspectRatio: (itemWidth / itemHeight),
                childAspectRatio: 3 / 3.6,
                crossAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[100],
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(1.0, 1.0))
                        ]),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0)),
                                image: DecorationImage(
                                    image: article[index].img == null
                                        ? AssetImage(
                                            'assets/images/placeholder.png')
                                        : NetworkImage(article[index].img),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                          child: Text(
                            article[index].title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.3,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 180.0,
                              height: 1.0,
                              color: Colors.black12,
                            ),
                            Container(
                              width: 30.0,
                              height: 3.0,
                              color: ColorsData.mainColor,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                article[index].source.name,
                                style: TextStyle(
                                  color: ColorsData.mainColor,
                                  fontSize: 9.0,
                                ),
                              ),
                              Text(
                                timeAgo(DateTime.parse(article[index].date)),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 9.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    }
  }
  String timeAgo(DateTime dateTime) {
    return timeago.format(dateTime, allowFromNow: true, locale: 'en');
  }
}
