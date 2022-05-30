import 'package:cloud_firestore/cloud_firestore.dart';


class PlantDetail {
  String id = '';
  String _difficulty = '';
  String _name = '';
  String _place = '';
  String _season = '';
  String _watercycle = '';
  bool _isFavorite = true;


  PlantDetail(this.id, this._difficulty, this._name,
      this._place, this._season, this._watercycle, this._isFavorite);

  String get difficulty => _difficulty;
  String get place => _place;
  String get season => _season;
  String get watercycle => _watercycle;
  bool get isFavorite => _isFavorite;


  PlantDetail.fromMap(dynamic obj) {
    this.id = (obj as QueryDocumentSnapshot).id; //obj['id'];
    this._difficulty = obj['difficulty'];
    this._name = obj['name'];
    this._place = obj['place'];
    this._season = obj['season'];
    this._watercycle = obj['watercycle'];
    this._isFavorite = obj['is_favorite'];


  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['difficulty'] = _difficulty;
    map['name'] = _name;
    map['place'] = _place;
    map['season'] = _season;
    map['watercycle'] = _watercycle;
    map['is_favorite'] = _isFavorite;


    return map;
  }
}