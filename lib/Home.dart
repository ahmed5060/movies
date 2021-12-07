// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/BrowseScreen.dart';
import 'package:movies_app/HomeScreen.dart';
import 'package:movies_app/SearchScreen.dart';
import 'package:movies_app/WatchScreen.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellowAccent,
        unselectedItemColor: Colors.white,
        iconSize: 35,
        currentIndex: selectedIndex,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        unselectedFontSize: 15,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Broewse',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
            ),
            label: 'Watch list',
          ),
        ],
      ),
      body: SafeArea(child: getScreen()),
    );
  }

  Widget getScreen(){
    if(selectedIndex == 0){
      return HomeScreen();
    }else if(selectedIndex == 1){
      return SearchScreen();
    }else if(selectedIndex == 2){
      return BrowseScreen();
    }else{
      return WatchScreen();
    }
  }
}
