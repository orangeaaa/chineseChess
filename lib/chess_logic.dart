import 'button.dart';
import 'package:tuple/tuple.dart';
import 'button_validation_util.dart';

class ChessLogic {
  Button _previousClickOnButton;
  ButtonValidationUtil _validationUtil;
  ChessLogic(ButtonValidationUtil validationUtil){
    _validationUtil = validationUtil;
  }

  void clickOnButton(Button clickOnButton) {
    if (_previousClickOnButton == null) {
      _previousClickOnButton = clickOnButton;
      return;
    }

    if (moveTo(clickOnButton.currentPosition)) {
       _validationUtil.updateMap(_previousClickOnButton.currentPosition, clickOnButton.currentPosition);
      _previousClickOnButton.setCurrentPosition(clickOnButton.currentPosition);
      clickOnButton.disableChess();
    }

    _previousClickOnButton = null;
  }

  void clickOnBoard(Tuple2 destination) {
    if (_previousClickOnButton == null) {
      return;
    }

    if (moveTo(destination)) {
       _validationUtil.updateMap(_previousClickOnButton.currentPosition, destination);
       _previousClickOnButton.setCurrentPosition(destination);
    }
    _previousClickOnButton = null;
  }

  bool moveTo(Tuple2 destinationPosition) {
    switch(_previousClickOnButton.name) {
      case "车": 
        return _validationUtil.juValidation(_previousClickOnButton.currentPosition, destinationPosition);
      case "马":
        return _validationUtil.maValidation(_previousClickOnButton.currentPosition, destinationPosition);
      case "象":
        return _validationUtil.xiangValidation(_previousClickOnButton.currentPosition, destinationPosition, _previousClickOnButton.group);
      case "士":
        return _validationUtil.shiValidation(_previousClickOnButton.currentPosition, destinationPosition);
      case "将":
        return _validationUtil.shuaiValidation(_previousClickOnButton.currentPosition, destinationPosition);
      case "帅":
        return _validationUtil.shuaiValidation(_previousClickOnButton.currentPosition, destinationPosition);
      default:
       return false;
    }
  }



  Button get previousClickOnButton => _previousClickOnButton;
}