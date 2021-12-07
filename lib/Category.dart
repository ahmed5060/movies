// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movies_app/DescriptionScreen.dart';
import 'package:movies_app/Network/http.dart';
import 'Models/category_data.dart';

class CategoryDataScreen extends StatefulWidget {

  var name;
  CategoryDataScreen(this.name);

  @override
  State<CategoryDataScreen> createState() => CategoryDataScreenState(name);
}

class CategoryDataScreenState extends State<CategoryDataScreen> {

  List<Results> Data = [];

  var name;
  CategoryDataScreenState(this.name);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "${name.toString()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DescriptionScreen(Data[index].id)),
                            );
                          },
                            child: Image.network("https://image.tmdb.org/t/p/w500${Data[index].posterPath}",scale: 4,),
                        ),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${Data[index].originalTitle}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${Data[index].releaseDate}",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "${Data[index].overview}",
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white,
                      ),
                    );
                  },
                  itemCount: Data.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCategoryData() {
    ApiManager.getCategoryData("https://api.themoviedb.org/3/discover/movie?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US&sort_by=popularity.desc&with_genres=${name.toString()}&with_watch_monetization_types=flatrate").then((value) {
      Data = value.results ?? [];

      print(Data[0].overview);
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }
}