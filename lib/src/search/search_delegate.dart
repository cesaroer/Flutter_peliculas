import 'package:flutter/material.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

//Clase para el buscador
class DataSearch extends SearchDelegate {
  String seleccion = "";
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    "Spiderman",
    "Capitan america",
    "Spiderman 2",
    "Capitan america 2",
    "Shazam",
    "Batman",
    "Superman"
  ];
  final peliculasRecientes = [
    "Spiderman",
    "Capitan america",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro AppBar , para cancelar o limpiar la busqueda

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          //Aqui se guarda todo lo que la persona escriba en el search
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar, como el icono de regresar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Metodo interno para cerrar el search delegate
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al teclear
    // Mostramos un list o table view con elementos

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map(
              (pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage("assets/img/no-image.jpg"),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = "";
                    Navigator.pushNamed(context, "detalle",
                        arguments: pelicula);
                  },
                );
              },
            ).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Sugerencias que aparecen al teclear
  //   // Mostramos un list o table view con elementos

  //   //Si query es "" entonces dejo peliculas sugeridas,
  //   //si no filtro sobre la lista de peliculas y lo muestro
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((pelicula) => pelicula.toLowerCase().startsWith(query))
  //           .toList();

  //   return ListView.builder(
  //       itemCount: listaSugerida.length,
  //       itemBuilder: (context, i) {
  //         return ListTile(
  //           leading: Icon(Icons.movie),
  //           title: Text(listaSugerida[i]),
  //           onTap: () {
  //             seleccion = listaSugerida[i];
  //             showResults(context);
  //           },
  //         );
  //       });
  // }
}
