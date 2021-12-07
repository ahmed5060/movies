import 'dart:convert';

import 'package:movies_app/Models/category_data.dart';
import 'package:movies_app/Models/category_names.dart';
import 'package:movies_app/Models/movie_details.dart';
import 'package:movies_app/Models/new_release.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/Models/search_result.dart';
import 'package:movies_app/Models/similar.dart';

class ApiManager{

  static Future<New_release> get(String Url) async{
    Uri url = Uri.parse(Url);
     var response = await http.get(url);

     if(response.statusCode == 200){
       return New_release.fromJson(jsonDecode(response.body));
     }
     throw Exception("server error??????????????? A7A");
  }

  static Future<MovieDetails> getDetails(String Url) async{
    Uri url = Uri.parse(Url);
    var response = await http.get(url);

    if(response.statusCode == 200){
      return MovieDetails.fromJson(jsonDecode(response.body));
    }
    throw Exception("server error??????????????? A7A");
  }

  static Future<Similar> getSimilar(String Url) async{
    Uri url = Uri.parse(Url);
    var response = await http.get(url);

    if(response.statusCode == 200){
      return Similar.fromJson(jsonDecode(response.body));
    }
    throw Exception("server error??????????????? A7A");
  }

  static Future<SearchResult> getSearchResult(String Url) async{
    Uri url = Uri.parse(Url);
    var response = await http.get(url);

    if(response.statusCode == 200){
      return SearchResult.fromJson(jsonDecode(response.body));
    }
    throw Exception("server error??????????????? A7A");
  }

  static Future<CategoryNames> getCategory(String Url) async{
    Uri url = Uri.parse(Url);
    var response = await http.get(url);

    if(response.statusCode == 200){
      return CategoryNames.fromJson(jsonDecode(response.body));
    }
    throw Exception("server error??????????????? A7A");
  }

  static Future<CategoryData> getCategoryData(String Url) async{
    Uri url = Uri.parse(Url);
    var response = await http.get(url);

    if(response.statusCode == 200){
      return CategoryData.fromJson(jsonDecode(response.body));
    }
    throw Exception("server error??????????????? A7A");
  }

}