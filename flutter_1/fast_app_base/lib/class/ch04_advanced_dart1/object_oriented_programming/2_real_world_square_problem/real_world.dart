abstract class AbstractRectangular {
  double get height;
  double get width;
}

class Rectangular extends AbstractRectangular {
  @override
  double height;
  @override
  double width;

  Rectangular(this.width, this.height);
}

class Square extends AbstractRectangular {
  double side;

  Square(this.side);

  @override
  double get height => side;

  @override
  double get width => side;
}

main() {
  // 1.
  // final square = Square(10);

  // square.height = 30;

  // 2.
  // final Rectangular rectangular = Square(10);
  // rectangular.height = 40;

  // print(rectangular.width);

  final AbstractRectangular rectangular = getRectangular();
  print(rectangular.width);
  print(rectangular.height);
  // rectangular.height = 40;

  if (rectangular is Rectangular) {
    rectangular.height = 50;
  } else if (rectangular is Square) {
    rectangular.side = 40;
  }

  switch (rectangular) {
    case Rectangular():
      rectangular.height = 50;
    case Square():
      rectangular.side = 40;
  }

  print(rectangular.width);
}

AbstractRectangular getRectangular() {
  return Square(10);
}
