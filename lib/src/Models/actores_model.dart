class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json["adult"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    originalName = json["original_name"];
    popularity = json["popularity"];
    profilePath = json["profile_path"];
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    order = json["order"];
    job = json["job"];
  }

  getFotoImg() {
    if (profilePath == null) {
      return "https://lh3.googleusercontent.com/proxy/hc6X4mmrrku5Tnyvf55X0rKl-hE5poAFAY4SGlYAq6R9JNlH1mJw_DrIFHGmWShxIaaXhOLe6y0nhHnQR4hvOWj8GgW6n0Zl-DFGBzqoHIGq13CcFpYNMHl8oB2BhNI";
    } else {
      return "http://image.tmdb.org/t/p/w500/$profilePath";
    }
  }
}
