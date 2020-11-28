import 'package:angular/angular.dart';
import 'button.dart';
import 'chess_logic.dart';
import 'dart:html';

@Component(
  selector: 'chess-button',
  templateUrl: 'chess_button.html',
  styleUrls: ['chess_button.css'],
  )

class ChessButtonComponent {
  @Input()
  Button button;

  @Input()
  ChessLogic chessLogic;

  static final buttonLeftVariation = 15;
  static final buttonTopVariation = 15;

  void onClick() {
    chessLogic.clickOnButton(button);
    if (!button.alive) {
      print(button.id);
      document.querySelector('#' + button.id).style.visibility = "hidden";
    }
  }

  // Move to right distance.
  String get leftPixel => (button.currentPosition.item1 - buttonLeftVariation).toString() + "px";
  String get topPixel => (button.currentPosition.item2 - buttonTopVariation).toString() + "px";
  String get name => button.name;
  String get currentLocation => button.currentPosition.toString();
}