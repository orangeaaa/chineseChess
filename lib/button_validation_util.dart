import 'button.dart';
import 'package:tuple/tuple.dart';

class ButtonValidationUtil {
  Map<Tuple2, Button> _positionToButtonMap;
  ButtonValidationUtil(Map<Tuple2, Button> positionToButtonMap) {
    _positionToButtonMap = positionToButtonMap;
  }

  void updateMap(Tuple2 previousPosition, Tuple2 destination) {
    _positionToButtonMap[destination] = _positionToButtonMap[previousPosition];
    _positionToButtonMap.remove(previousPosition);
  }

  bool juValidation(Tuple2 currentPosition, Tuple2 destinationPosition) {
    var availableDestination = <Tuple2>{};

    // Lookup available movement on left side. 
    for (int i = currentPosition.item1; i >= 50; i -= 50) {
      var tmpPosition = Tuple2(i, currentPosition.item2);
      availableDestination.add(tmpPosition);
      if (_positionToButtonMap.containsKey(tmpPosition) && tmpPosition != currentPosition) {
        break;
      }
    }

    // Lookup available movement on right side. 
    for (int i = currentPosition.item1; i <= 450; i += 50) {
      var tmpPosition = Tuple2(i, currentPosition.item2);
      availableDestination.add(tmpPosition);
      if (_positionToButtonMap.containsKey(tmpPosition) && tmpPosition != currentPosition) {
        break;
      }
    }
    // Lookup available movement upwards. 
    for (int i = currentPosition.item2; i >= 30; i -= 50) {
      var tmpPosition = Tuple2(currentPosition.item1, i);
      availableDestination.add(tmpPosition);
      if (_positionToButtonMap.containsKey(tmpPosition) && tmpPosition != currentPosition) {
        break;
      }
    }

    // Lookup available movement downwards. 
    for (int i = currentPosition.item2; i <= 480; i += 50) {
      var tmpPosition = Tuple2(currentPosition.item1, i);
      availableDestination.add(tmpPosition);
      if (_positionToButtonMap.containsKey(tmpPosition) && tmpPosition != currentPosition) {
        break;
      }
    }

    bool inSameGroup = 
        (_positionToButtonMap[destinationPosition]?.group 
        == _positionToButtonMap[currentPosition]?.group) ?? false; 

    return availableDestination.contains(destinationPosition) && !inSameGroup;

  }

  bool maValidation(Tuple2 currentPosition, Tuple2 destinationPosition) {
    var availableDestination = <Tuple2>{};

    // Lookup available movement on left. 
    if (currentPosition.item1 >= 150 
        && !_positionToButtonMap.containsKey(
          Tuple2(currentPosition.item1 - 50, currentPosition.item2))) {
      if (currentPosition.item2 >= 80) {
        availableDestination.add(
          Tuple2(currentPosition.item1 - 100, currentPosition.item2 - 50));
      }

      if (currentPosition.item2 <= 430) {
        availableDestination.add(
          Tuple2(currentPosition.item1 - 100, currentPosition.item2 + 50));
      }
    }

    // Lookup available movement on right. 
    if (currentPosition.item1 <= 350 
        && !_positionToButtonMap.containsKey(
          Tuple2(currentPosition.item1 + 50, currentPosition.item2))) {
      if (currentPosition.item2 >= 80) {
        availableDestination.add(
          Tuple2(currentPosition.item1 + 100, currentPosition.item2 - 50));
      }

      if (currentPosition.item2 <= 430) {
        availableDestination.add(
          Tuple2(currentPosition.item1 + 100, currentPosition.item2 + 50));
      }
    }

    // Lookup available movement on top. 
    if (currentPosition.item2 >= 130 
        && !_positionToButtonMap.containsKey(
          Tuple2(currentPosition.item1, currentPosition.item2 - 50))) {
      if (currentPosition.item1 >= 100) {
        availableDestination.add(
          Tuple2(currentPosition.item1 - 50, currentPosition.item2 - 100));
      }

      if (currentPosition.item1 <= 400) {
        availableDestination.add(
          Tuple2(currentPosition.item1 + 50, currentPosition.item2 - 100));
      }
    }

    // Lookup available movement on bottom. 
    if (currentPosition.item2 <= 380 
        && !_positionToButtonMap.containsKey(
          Tuple2(currentPosition.item1, currentPosition.item2 + 50))) {
      if (currentPosition.item1 >= 100) {
        availableDestination.add(
          Tuple2(currentPosition.item1 - 50, currentPosition.item2 + 100));
      }

      if (currentPosition.item1 <= 400) {
        availableDestination.add(
          Tuple2(currentPosition.item1 + 50, currentPosition.item2 + 100));
      }
    }

    bool inSameGroup = 
        (_positionToButtonMap[destinationPosition]?.group 
        == _positionToButtonMap[currentPosition]?.group) ?? false; 

    return availableDestination.contains(destinationPosition) && !inSameGroup;
  }

  bool xiangValidation(Tuple2 currentPosition, Tuple2 destinationPosition, int group) {
    var availableDestination = <Tuple2>{};
    var relativeCurrentPositionX = currentPosition.item1;
    var relativeCurrentPositionY = currentPosition.item2;
    var relativeDestinationPositionX = destinationPosition.item1;
    var relativeDestinationPositionY = destinationPosition.item2;

    if (group == 2) {
      relativeCurrentPositionY = 480 - relativeCurrentPositionY + 30;
      relativeDestinationPositionY = 480 - relativeDestinationPositionY + 30;
    }

    // Move to top left
    if (relativeCurrentPositionX >= 150 && relativeCurrentPositionY >= 130 
        && !_positionToButtonMap.containsKey(
          Tuple2(relativeCurrentPositionX - 50, relativeCurrentPositionY - 50))) {
      availableDestination.add(Tuple2(relativeCurrentPositionX - 100, relativeCurrentPositionY - 100));
    }

    // Move to top right
    if (relativeCurrentPositionX <= 350 && relativeCurrentPositionY >= 130 
        && !_positionToButtonMap.containsKey(
          Tuple2(relativeCurrentPositionX + 50, relativeCurrentPositionY - 50))) {
      availableDestination.add(Tuple2(relativeCurrentPositionX + 100, relativeCurrentPositionY - 100));
    }

    // Move to bottom left
    if (relativeCurrentPositionX >= 150 && relativeCurrentPositionY <= 130 
        && !_positionToButtonMap.containsKey(
          Tuple2(relativeCurrentPositionX - 50, relativeCurrentPositionY + 50))) {
      availableDestination.add(Tuple2(relativeCurrentPositionX - 100, relativeCurrentPositionY + 100));
    }

    // Move to bottom right
    if (relativeCurrentPositionX <=350 && relativeCurrentPositionY <= 130 
        && !_positionToButtonMap.containsKey(
          Tuple2(relativeCurrentPositionX + 50, relativeCurrentPositionY + 50))) {
      availableDestination.add(Tuple2(relativeCurrentPositionX + 100, relativeCurrentPositionY + 100));
    }

    bool inSameGroup = 
        (_positionToButtonMap[destinationPosition]?.group 
        == _positionToButtonMap[currentPosition]?.group) ?? false; 

    return availableDestination.contains(
      Tuple2(relativeDestinationPositionX, relativeDestinationPositionY)) 
      && !inSameGroup;
  }

  bool shiValidation(Tuple2 currentPosition, Tuple2 destinationPosition) {
    var availableDestination = <Tuple2>{
      Tuple2(200, 30),
      Tuple2(300, 30),
      Tuple2(250, 80),
      Tuple2(200, 130),
      Tuple2(300, 130),
      Tuple2(200, 480),
      Tuple2(300, 480),
      Tuple2(250, 430),
      Tuple2(200, 380),
      Tuple2(300, 380),
    };

    bool inSameGroup = 
      (_positionToButtonMap[destinationPosition]?.group 
      == _positionToButtonMap[currentPosition]?.group) ?? false; 

    if ((destinationPosition.item1 - currentPosition.item1).abs() == 50 
      && (destinationPosition.item2 - currentPosition.item2).abs() == 50) {
      return true && !inSameGroup;
    }

    return false;
  }

  bool shuaiValidation(Tuple2 currentPosition, Tuple2 destinationPosition) {
    bool inSameGroup = 
      (_positionToButtonMap[destinationPosition]?.group 
      == _positionToButtonMap[currentPosition]?.group) ?? false; 
    if (inSameGroup) return false;

    if ((destinationPosition.item1 <= 300 
        && destinationPosition.item1 >= 200 
        && destinationPosition.item2 >= 30
        && destinationPosition.item2 <= 130) ||
        ((destinationPosition.item1 <= 300 
        && destinationPosition.item1 >= 200 
        && destinationPosition.item2 >= 380
        && destinationPosition.item2 <= 480))) {
      if (destinationPosition.item1 == currentPosition.item1 
          && (destinationPosition.item2 - currentPosition.item2).abs() == 50) {
        return true;
      }

      if (destinationPosition.item2 == currentPosition.item2 
          && (destinationPosition.item1 - currentPosition.item1).abs() == 50) {
        return true;
      }
    }

    if (_positionToButtonMap[destinationPosition]?.name == "将" 
        || _positionToButtonMap[destinationPosition]?.name == "帅") {
      return true;
    }

    return false;
  }
}