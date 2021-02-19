import 'package:flutter/material.dart';
import 'package:news_app/bloc/get_sources_bloc.dart';
import 'package:news_app/elements/error_element.dart';
import 'package:news_app/elements/loader_element.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/model/source_response.dart';

class TopChannels extends StatefulWidget {
  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSourceBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourceBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return buildErrorWidget(snapshot.data.error);
          }
          return _buildTopChannels(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildTopChannels(SourceResponse data) {
    List<SourceModel> sources = data.sources;

    if (sources.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [Text("No Sources")],
        ),
      );
    } else {
      return Container(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0),
              width: 80.0,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Hero(
                      tag: sources[index].id,
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.0, 1.0))
                            ],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/${sources[index].id}.png",)
                            ),),
                          // image: AssetImage(
                          //     "assets/images/${sources[index].id}.png")
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sources[index].name,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sources[index].category,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 9.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
