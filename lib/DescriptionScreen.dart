// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Network/http.dart';
import 'Models/similar.dart';


class DescriptionScreen extends StatefulWidget {

  var id;

  DescriptionScreen(this.id);

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState(id);
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  var id;

  _DescriptionScreenState(this.id);

  var backdrop_path;
  var original_title;
  var release_date;
  var poster_path;
  var vote_average;
  var overview;
  List<String> genres = [];
  List<Results> similar = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    getSimilar();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: ConditionalBuilder(
          condition: original_title == null,
          fallback: (context) => Text(""),
          builder: (context) => Text(original_title),
        ),
      ),
      body: SingleChildScrollView(
        child: ConditionalBuilder(
          condition: similar.length != 0,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network("https://image.tmdb.org/t/p/w500${backdrop_path}"),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  original_title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  release_date,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network("https://image.tmdb.org/t/p/w500${poster_path}",scale: 3.5,),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                for (var cat in genres)
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                                      child: Text(
                                        cat,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),

                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              overview,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset("assets/images/star.png",scale: .6,),
                                SizedBox(width: 5,),
                                Text(
                                  vote_average.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: 360,
                color: Color.fromRGBO(40,42, 40, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("More Like This",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      SizedBox(height: 10,),
                      ConditionalBuilder(
                        condition: similar.length != 0,
                        fallback: (context) => Container(),
                        builder: (context) => Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context,index){
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
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => DescriptionScreen(similar[index].id)),
                                            );
                                          },
                                          child: Image.network("https://image.tmdb.org/t/p/w500${similar[index].posterPath}")),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/images/star.png"),
                                            SizedBox(width: 5,),
                                            Text(
                                              "${similar[index].voteAverage}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          "${similar[index].originalTitle}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        child: Text(
                                          "${similar[index].releaseDate}",
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
            ],
          ),
        ),
      ),
    );
  }

  void getDetails() {
    ApiManager.getDetails("https://api.themoviedb.org/3/movie/${id}?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US").then((value) {

      backdrop_path = value.backdropPath;
      original_title = value.originalTitle;
      release_date = value.releaseDate;
      poster_path = value.posterPath;
      vote_average = value.voteAverage;
      overview = value.overview;
      //genres = MovieDetails.fromJson(value.genres);
      for(var gg in value.genres!){
          genres.add(gg.name);
      }
      //genres = value.genres![0].name.toString();
      print(overview);
      print(genres[0]);
      print("----------------------------");
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }

  void getSimilar() {
    ApiManager.getSimilar("https://api.themoviedb.org/3/movie/${id}/similar?api_key=b4e0644efa9c3b27b91c3b8565b06e39&language=en-US&page=1").then((value) {
      similar = value.results ?? [];
      setState(() {});
    }).catchError((error) {
      print("----------------------------");
      print(error.toString());
    });
  }

}
