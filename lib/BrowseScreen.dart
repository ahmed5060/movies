// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/Category.dart';
import 'package:movies_app/Network/http.dart';

import 'Models/category_names.dart';

class BrowseScreen extends StatefulWidget {

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<Genres> categoryName = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryName();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           const Text(
            "Browse Category",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
                itemCount: categoryName.length,
                itemBuilder: (context,index){
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryDataScreen(categoryName[index].name)),
                              );
                            },
                            child: Stack(
                              children: [
                                Image.asset("assets/images/Image-1.png"),
                                 Text(
                                    "${categoryName[index].name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26
                                  ),
                                ),
                              ],
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  void getCategoryName() {
    ApiManager.getCategory("https://api.themoviedb.org/3/genre/movie/list?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US").then((value) {
      categoryName = value.genres ?? [];
      print(categoryName[0].name);
      setState(() {

      });
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }
}