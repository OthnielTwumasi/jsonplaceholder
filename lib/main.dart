import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/post_model.dart';
import 'package:jsonplaceholder/services/post_services.dart';

void main () {
  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestPage(),
    );
  }

  

}



class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  PostServices services = PostServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PostModel>>(future: services.fetchPostList(), builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(!snapshot.hasData||snapshot.data!.isEmpty){
          return Center(child: Text("No data available"),);
        }
        else if (snapshot.hasError){
          return Center(child: Text("Error Encountered"),);
        }
        else{
          return ListView.builder(itemBuilder: (BuildContext context, int index){
            return ListTile(title: Text(snapshot.data![index].title),subtitle:  Text(snapshot.data![index].body),);
          },itemCount: snapshot.data!.length,);
        }
      }),
    );
  }
}