import 'package:todo_statemanagement/common/common.dart';

void main() async {
  /// List와 Iterable
  // final List list = ['blue', 'yellow', 'red'];
  // Iterable: 객체에서 항목을 한 번에 하나씩 가져오기 위한 인터페이스
  // final iterator = list.iterator;
  // print(iterator.current);
  // iterator.moveNext();
  // print(iterator.current);

  // list.forEach((element) {
  //   print(element);
  // });
  // for (final color in [1, 2, 3, 4, 5]) {
  //   print(color);
  // }

  /// sync*로 Iterable 만들기
  // for (final message in countIterable(5)) {
  //   print(message);
  // }
  await for (final message in countStream(3)) {
    print(message);
  }

  /// async*로 Stream 만들기

  /// yield*를 통해서 Iterable & Stream 연장시키기
}

Iterable<String> countIterable(int max) sync* {
  for (int i = 1; i <= max; i++) {
    yield i.toString();
  }
  yield '새해 복 많이 받으세요';

  yield* ['a', 'b', 'c'];
}

/// Generator

Stream<String> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await sleepAsync(1.seconds);
    yield i.toString();
  }
  yield '새해 복 많이 받으세요';
  yield* countStream(to);
}

Future sleepAsync(Duration duration) {
  return Future.delayed(duration, () => {});
}
