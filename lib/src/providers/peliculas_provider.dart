import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/Models/actores_model.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';
import "package:http/http.dart" as http;

class PeliculasProvider {
  String _apiKey = "8573a35068a01db80b732e80e04d33dc";
  String _url = "api.themoviedb.org";
  String language = "es-ES";
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  //Este es mi stream y con broadcast cualquier lo puede escuchar
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //Es el sink de el streamController o sea lo que introduce data
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Este es el stream o sea lo que escucha
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //Con esto cerramos el stream para que no se hagan varios
  //Ya que el stateless widget se dibuja cada vez que se llama
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);
    final peliculas = Peliculas.fromJsonList(decodedData["results"]);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {"api_key": _apiKey, "languaje": language});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "languaje": language,
      "page": _popularesPage.toString()
    });

    final response = await _procesarRespuesta(url);
    _populares.addAll(response);
    popularesSink(_populares);

    _cargando = false;
    return response;
  }

  //Peticion para obtener cast de una pelicula
  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.http(_url, "3/movie/${peliId}/credits",
        {"api_key": _apiKey, "languaje": language});

    //Aqui ejecutamos la petición y esperamos con await
    final resp = await http.get(url);

    //En decode nos pide un json plano o sea el body del resp
    final decodedData = json.decode(resp.body);
    final cast = Cast.fromJsonList(decodedData["cast"]);

    return cast.actores;
  }
}
