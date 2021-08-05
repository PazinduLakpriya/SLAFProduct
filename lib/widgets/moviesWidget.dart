// import 'package:flutter/material.dart';
// import 'package:hello_movies/models/movie.dart';
//
// class MoviesWidget extends StatelessWidget {
//
//   final List<Movie> movies;
//   List<Movie> moviesDisplay;
//
//   MoviesWidget({this.movies,this.moviesDisplay});
//
//   bool _isLoading = true;
//
//
//   @override
//   Widget build(BuildContext context) {
//     print("MoviesWidget");
//     return ListView.builder(
//       itemCount: movies.length,
//       itemBuilder: (context, index) {
//         if(!_isLoading) {
//           return  index == 0 ? _searchBar() : _listItem(index - 1);
//         }
//         else{
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       }
//     );
//   }
//
//
//
// }
