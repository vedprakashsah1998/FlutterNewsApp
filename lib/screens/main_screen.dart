import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/bottom_navbar_bloc.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/style/theme.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: ColorsData.mainColor,
          title: Text(
            "News App",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return HomeScreen();
              case NavBarItem.SOURCES:
                return testScreen();
              case NavBarItem.SEARCH:
                return testScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[100],
                      spreadRadius: 0,
                      blurRadius: 10.0)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: ColorsData.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: ColorsData.mainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Home"),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Source"),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("Search"),
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

  Widget testScreen() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Test Screen")],
      ),
    );
  }
}
