import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    print("Peliculas.leng : ${peliculas.length}");

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: double.infinity,
      height: _screenSize.height * 0.5,
      child: Swiper(
        layout: SwiperLayout.STACK,
        //layout: SwiperLayout.TINDER,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          var _random = new Random();
          var _diceface = _random.nextInt(1000) + 1;
          peliculas[index].uniqueId =
              "${peliculas[index].id}-tarjeta-$_diceface";

          print("UniqueIDCreated : ${peliculas[index].uniqueId}");

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                  timeDilation = 1.5;
                  Navigator.pushNamed(context, "detalle",
                      arguments: peliculas[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage("assets/img/no-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //puntitos como page controller
        //pagination: SwiperPagination(),
        //barras en los lados
        //control: SwiperControl(),
      ),
    );
  }
}
