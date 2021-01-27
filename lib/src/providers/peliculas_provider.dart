import 'dart:convert';

import 'package:peliculas/src/Models/pelicula_model.dart';
import "package:http/http.dart" as http;

class PeliculasProvider {
  String _apiKey = "8573a35068a01db80b732e80e04d33dc";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apiKey, "languaje": _language});

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData["results"]);

    return peliculas.items;
  }
}