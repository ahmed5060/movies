// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/DescriptionScreen.dart';
import 'package:movies_app/Network/http.dart';
import 'Models/search_result.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var controller = TextEditingController();
  var x;

  List<Results> SearchResullt = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: TextField(
                  onChanged: (v){
                    setState(() {
                      x = controller.text;
                      getSearch();
                    });
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            x = controller.text;
                            getSearch();
                          });
                        },
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),

                      border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ConditionalBuilder(
              condition: x != null,
              fallback: (context) => Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/movies.png"),
                      SizedBox(height: 10,),
                      Text("No Movies Yet", style: TextStyle(color: Colors.white, fontSize: 18),),
                    ],
                  ),
              ),
              builder: (context) => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: SearchResullt.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Color.fromRGBO(52, 53, 52, 1),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DescriptionScreen(SearchResullt[index].id)),
                                  );
                                },
                                child: Container(
                                  child: Image.network(
                                      "https://image.tmdb.org/t/p/w500${SearchResullt[index].posterPath}",scale: 5,),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    "${SearchResullt[index].originalTitle}",
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
                                    "${SearchResullt[index].releaseDate}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }

  void getSearch() {
    ApiManager.getSearchResult("https://api.themoviedb.org/3/search/movie?api_key=b4e0644efa9c3b27b91c3b8565b06e39&query=${x.toString()}").then((value) {
      SearchResullt = value.results ?? [];
      print(SearchResullt[0].overview);
      print(x.toString());
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }
}