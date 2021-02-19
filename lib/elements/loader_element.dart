import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
Widget buildLoadingWidget(){
  return Container(
    child: Column(
      children: [
        CupertinoActivityIndicator()
      ],
    ),
  );
}