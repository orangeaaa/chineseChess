import 'package:tuple/tuple.dart';

/// The position on left top corner is (50,30). There is 
/// a 20 px tolerant range for clicks. The interval between
/// different position is 50 px. Maximize position is 
/// (450, 480)
class Position {
  static Tuple2<int, int> locationOnBoard(Tuple2 position){
    var rowPixel = position.item1;
    var columnPixel = position.item2;

    // Out of board.
    if (rowPixel < 30 
        || columnPixel < 10  
        || rowPixel > 470 
        || columnPixel > 500) {
      return null;
    }

    var xAxisDestination = 50;
    var yAxisDestination = 30;

    // Filter out the first row
    if (rowPixel > 80) {
      // Viariation between click point and movable point.
      var pixelVariation = (rowPixel - 50)%50;
      if ( pixelVariation < 20) {
        xAxisDestination = rowPixel - pixelVariation;
      } else if (pixelVariation > 30) {
        xAxisDestination = rowPixel - pixelVariation + 50;
      } else {
        return null;
      }
    }

    if (columnPixel > 60) {
      // Viariation between click point and movable point.
      var pixelVariation = (columnPixel - 30)%50;
      if ( pixelVariation < 20) {
        yAxisDestination = columnPixel - pixelVariation;
      } else if (pixelVariation > 30) {
        yAxisDestination = columnPixel - pixelVariation + 50;
      } else {
        return null;
      }
    }

    return Tuple2(xAxisDestination, yAxisDestination);
  }

}