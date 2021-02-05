import 'package:flutter/material.dart';

//Clase para el buscador
class DataSearch extends SearchDelegate {
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen al teclear
    return Container();
  }
}
