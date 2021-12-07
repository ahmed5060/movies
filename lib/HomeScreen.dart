// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/DescriptionScreen.dart';
import 'package:movies_app/Models/new_release.dart';
import 'package:movies_app/Network/http.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Results> popular = [];
  List<Results> recomended = [];

  bool isAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopular();
    getRecomended();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 310,
            color: Colors.black,
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Image.asset("assets/images/Image-1.png"),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Image.asset("assets/images/Image.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Dora and the last city of gold",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "2019",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            color: Color.fromRGBO(40, 42, 40, 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Released",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: popular.length != 0,
                    fallback: (context) => Center(child: CircularProgressIndicator()),
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: popular.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DescriptionScreen(popular[index].id)),
                                );
                              },
                              child: Stack(
                                children: [
                                  Image.network("https://image.tmdb.org/t/p/w500${popular[index].posterPath}"),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(isAdded == false){
                                          isAdded = true;
                                          // add to database
                                        }else{
                                          isAdded = false;
                                          // remove from database
                                        }
                                      });

                                    },
                                      child: isAdded? Image.asset("assets/images/added.png"):
                                      Image.asset("assets/images/add.png"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            height: 360,
            color: Color.fromRGBO(40, 42, 40, 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recomended",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: recomended.length != 0,
                    fallback: (context) => Center(child: CircularProgressIndicator()),
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Color.fromRGBO(52, 53, 52, 1),
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DescriptionScreen(recomended[index].id)),
                                      );
                                    },
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w500${recomended[index].posterPath}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/images/star.png"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${recomended[index].voteAverage}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      "${recomended[index].originalTitle}",
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      "${recomended[index].releaseDate}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void getPopular() {
    ApiManager.get("https://api.themoviedb.org/3/movie/popular?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US&page=1").then((value) {
      popular = value.results ?? [];
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }
  void getRecomended() {
    ApiManager.get("https://api.themoviedb.org/3/movie/top_rated?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US&page=1").then((value) {
      recomended = value.results ?? [];
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }


}
