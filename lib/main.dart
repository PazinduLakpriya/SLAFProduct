//// @dart=2.9
import 'dart:io';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hello_movies/models/movie.dart';
import 'package:hello_movies/widgets/moviesWidget.dart';
import 'package:http/http.dart' as http;

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  // List<Movie> _movies = new List<Movie>();
  // List<Movie> _moviesDisplay = new List<Movie>();

  List<Movie> _movies = [];
  List<Movie> _moviesDisplay = [];


  String _chosenValue = "Colombo HQ";


  bool _isLoading = true;
  var movies;

  @override
  void initState() {
    super.initState();
    print("initState upper");
    _populateAllMovies();
    _fetchAllMovies().then((value) {
      setState(() {
        _isLoading = false;
        _movies.addAll(value);
        _moviesDisplay = _movies;
      });
    });
    print("initState lower");
  }

  void _populateAllMovies() async {
    print("_populateAllMovies upper");
    // final movies = await _fetchAllMovies();
    movies = await _fetchAllMovies();
    _movies = movies;
    // setState(() {
    //   _movies = movies;
    //   print("_populateAllMovies");
    // });
  }
  // Future(() => MaterialApp);

  Future<List<Movie>> _fetchAllMovies() async {
    // HttpClient createHttpClient = new HttpClient();
    print("_fetchAllMovies upper");
    final response =
        // await http.get("http://192.168.43.183:45459/getproducts.ashx");
    await http.get("https://192.168.8.189:45455/Handler2.ashx");
    print("response");
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Table"];
      print(list);
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      print("not working");
      throw Exception("Failed to load movies!");
    }
  }


  @override
  Widget build(BuildContext context) {
    print("build");
    return MaterialApp(
        title: "Product App",
        home: Scaffold(
          appBar: AppBar(title: Text("Products")),
          body: Column(
            children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton<String>(
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>[
                    'Colombo HQ',
                    'Katunayake',
                    'Rathmalana',
                    'Anuradhapura',
                    'China-Bay',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _chosenValue = newValue!;
                    });
                  },
                ),
              ),
              ]
            ),
              Flexible(
                child: Container(
                    child: ListView.builder(
                      // itemCount: movies.length,
                      itemBuilder: (context, index) {
                        if (!_isLoading) {
                          return index == 0 ? _searchBar() : _listItem(index - 1);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                      itemCount: _moviesDisplay.length,
                    ),
                  ),
              ),
            ]
          ),
        ));
  }

  _searchBar() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 8.0),
        child: TextField(
          decoration: InputDecoration(hintText: "Search..."),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _moviesDisplay = _movies.where((movie) {
                // var postTitle = post.title.toLowerCase();
                var postTitle = movie.product_name.toLowerCase();
                // var postTitle = movie.product_name;
                return postTitle.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }

  _listItem(index) {
    final movie = movies[index];
    // print(movie.product_name);
    return Container(
      height: 125,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //   ),------add stack
              //   // width: 100,
              //   // child: ClipRRect(
              //   //   child: Image.network(movie.id),
              //   //   borderRadius: BorderRadius.circular(10),
              //   // )
              // ),

              Expanded(
                flex: 2,
                child: Image.network('https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=625&q=80',
                  fit: BoxFit.cover,),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _moviesDisplay[index].product_name,
                                  style: TextStyle(
                                      fontSize: 21, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop_outlined,
                                      color: Colors.grey,
                                      size: 17.0,
                                    ),
                                    Text(
                                      _moviesDisplay[index].product_location,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Text(
                                  _moviesDisplay[index].quantity.toString() + " In Stocks ",
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Rs" + _moviesDisplay[index].product_price.toString(),
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              )
            ],
              ),
        ),
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}