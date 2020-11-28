import 'package:tuple/tuple.dart';

class Button {
  Tuple2<int, int> _currentPosition;
  String _name;
  bool _alive;
  int _group;
  String _id;
  
  Button(Tuple2<int, int> currentPosition, String id, {int group, String name, bool alive = true}) {
    _currentPosition = currentPosition;
    _name = name;
    _alive = alive;
    _group = group;
    _id = id;
  }

  void setCurrentPosition (Tuple2<int, int> newPosition) {
    _currentPosition = newPosition;
  }

  void disableChess() {
    _alive = false;
  }

  Tuple2 get currentPosition => _currentPosition;
  String get name => _name;
  bool get alive => _alive;
  int get group => _group;
  String get id => _id;
}