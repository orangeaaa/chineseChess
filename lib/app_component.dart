import 'package:angular/angular.dart';
import 'dart:html';
import 'chess_button.dart';
import 'button.dart';
import 'package:tuple/tuple.dart';
import 'position.dart';
import 'chess_logic.dart';
import 'button_validation_util.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [ChessButtonComponent],
)
class AppComponent {
  static Button buttonJu1 = Button(Tuple2(50,30), "ju1", group: 1, name: "车");
  static Button buttonMa1 = Button(Tuple2(100,30), "ma1", group: 1, name: "马");
  static Button buttonXiang1 = Button(Tuple2(150,30), "xiang1", group: 1, name: "象");
  static Button buttonShi1 = Button(Tuple2(200,30), "shi1", group: 1, name: "士");
  static Button buttonShuai1 = Button(Tuple2(250,30), "shuai1", group: 1, name: "帅");
  static Button buttonJiang1 = Button(Tuple2(250,480), "jiang1", group: 2, name: "将");
  static Button buttonXiang3 = Button(Tuple2(150,480), "xiang3", group: 2, name: "象");

  static Map<Tuple2, Button> positionToButtonMap = {
    buttonJu1.currentPosition: buttonJu1, 
    buttonMa1.currentPosition: buttonMa1,
    buttonXiang1.currentPosition: buttonXiang1,
    buttonXiang3.currentPosition: buttonXiang3,
    buttonShi1.currentPosition: buttonShi1,
    buttonJiang1.currentPosition: buttonJiang1,
    buttonShuai1.currentPosition: buttonShuai1,
    };
  static ButtonValidationUtil validationUtil = ButtonValidationUtil(positionToButtonMap);

  var bottomUser = "wdpwk";
  var topUser="sbnhr";
  var currentPosition;

  ChessLogic chessLogic = ChessLogic(validationUtil);

  clickOnBoard(MouseEvent e) {
    currentPosition = Position.locationOnBoard(Tuple2(e.offset.x, e.offset.y));
    if (currentPosition != null) {
      chessLogic.clickOnBoard(currentPosition);
    }
  }

  String get previous => chessLogic.previousClickOnButton.name;
}
