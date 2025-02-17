import 'dart:convert';
import 'package:jsonplaceholder/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostServices {
final String baseUrl ="https://jsonplaceholder.typicode.com/";

Future<List<PostModel>> fetchPostList () async {
  try{
  final response = await http.get(Uri.parse("$baseUrl/posts"));
  if (response.statusCode ==200){
    List<dynamic> decodedData = jsonDecode(response.body);
    return PostModel.postList(decodedData);
  }
  else if (response.statusCode == 400){
    throw Exception("Incorrect Format");
  }
  else if (response.statusCode == 500){
    throw Exception("Internal Server Error");
  }
  else {
    throw Exception("Error");
  }
  }
  catch (e){
    throw Exception("Error: $e");
  }

  
}

}