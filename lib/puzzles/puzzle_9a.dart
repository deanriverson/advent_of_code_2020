import 'package:rxdart/rxdart.dart';

import '../file_utils.dart';

const preambleSize = 25;

void puzzle_9a() async {
  readLines('puzzle_9_input.txt').map(parseAsInt).bufferCount(preambleSize + 1, 1).map(processBuffer).listen(
        (_) => null,
        onError: (e) => print('Puzzle 9a answer is: $e'),
        cancelOnError: true,
      );
}

int processBuffer(List<int> buffer) {
  final sum = buffer.last;
  final xs = buffer.sublist(0, buffer.length - 1).toSet();
  final result = xs.any((el) => xs.contains(sum - el));
  return result ? sum : throw StateError('$sum is not valid!');
}
