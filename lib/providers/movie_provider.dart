import 'package:flutter/material.dart';
import 'package:imdb_flutter_app/models/movie_response.dart';
import 'package:imdb_flutter_app/utilities/api_helper.dart';

enum SEARCH_STATE { IDLE, SEARCHING, FOUND, NOT_FOUND }

class MovieProvider with ChangeNotifier {
  SEARCH_STATE searchState = SEARCH_STATE.IDLE;
  MovieResponse result = null;

  changeSearchState(SEARCH_STATE state) {
    searchState = state;
    notifyListeners();
  }

  Future searchMovie(String text) async {
    result = null;
    changeSearchState(SEARCH_STATE.SEARCHING);
    Map<String, dynamic> response = await ApiHelper.searchMovieApi(text);
    if (response != null && response['Response'] == 'True') {
      MovieResponse moviesResponse = MovieResponse.fromJson(response);
      result = moviesResponse;
      changeSearchState(SEARCH_STATE.FOUND);
    } else {
      changeSearchState(SEARCH_STATE.NOT_FOUND);
    }
  }
}
