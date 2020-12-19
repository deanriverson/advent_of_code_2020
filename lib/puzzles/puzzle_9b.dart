import 'dart:math';

import 'package:rxdart/rxdart.dart';

import '../file_utils.dart';

void puzzle_9b() async {
  const preambleSize = 25;
  const filePath = 'puzzle_9_input.txt';

  final preamble = await readLines(filePath).take(preambleSize).map(parseAsInt).toList();

  readLines(filePath)
      .map(parseAsInt)
      .bufferCount(preambleSize + 1, 1)
      .map(processBuffer)
      .scan(scanner, preamble)
      .where((xs) => xs.length == 1)
      .listen(
        (xs) => print('Puzzle 9b answer is ${xs[0]}'),
        onError: (_) => null,
        cancelOnError: true,
      );
}

int processBuffer(List<int> buffer) {
  final sum = buffer.last;
  final xs = buffer.sublist(0, buffer.length - 1).toSet();
  final result = xs.any((el) => xs.contains(sum - el));
  return result ? sum : -sum;
}

List<int> scanner(List<int> xs, y, _) {
  if (xs.length == 1) throw 'done';

  if (y >= 0) {
    xs.add(y);
    return xs;
  }

  // -y is the target sum; scan xs looking for summation sequence
  final seq = findSummingSequence(xs, -y);
  return [calculateAnswer(seq)];
}

List<int> findSummingSequence(List<int> xs, targetSum) {
  for (var i = 0; i < xs.length; ++i) {
    var sum = 0;
    final sublist = xs.sublist(i);

    for (var j = 0; j < sublist.length; ++j) {
      sum += sublist[j];
      if (sum == targetSum) {
        return sublist.sublist(0, j + 1);
      }
      if (sum > targetSum) break;
    }
  }
  throw StateError('no summation sequence found!');
}

int calculateAnswer(List<int> xs) => xs.reduce(min) + xs.reduce(max);
