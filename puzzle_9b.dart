import 'file_utils.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  const preambleSize = 25;
  const filePath = 'puzzle_9_input.txt';
  
  final preamble = await readLines(filePath)
    .take(preambleSize)
    .map(parseAsInt)
    .toList();

  readLines(filePath)
    .map(parseAsInt)
    .bufferCount(preambleSize + 1, 1)
    .map(processBuffer)
    .scan(scanner, preamble)
    .where((xs) => xs.length == 1)
    .listen((xs) => print("answer is ${xs[0]}"), 
      onError: (e) => print("Finished: $e"),
      cancelOnError: true
    );
}

int processBuffer(List<int> buffer) {
  final sum = buffer.last;
  final set = buffer.sublist(0, buffer.length - 1).toSet();

  final result = set.any((el) {
    final target = sum - el;
    return target != el && set.contains(target);
  });

  return result ? sum : -sum;
}

List<int> scanner(List<int> xs, y, _) {
  if (xs.length == 1) throw "done";

  if (y >= 0) {
    xs.add(y);
    return xs;
  }

  // -y is the target sum; scan xs looking for summation sequence
  final seq = findSummingSequence(xs, -y);
  return [calculateAnswer(seq)];
}

List<int> findSummingSequence(List<int> xs, targetSum) {
  for (int i = 0; i<xs.length; ++i) {
    int sum = 0;
    final sublist = xs.sublist(i);

    for (int j = 0; j<sublist.length; ++j) {
      sum += sublist[j];
      if (sum == targetSum) {
        return sublist.sublist(0, j+1);
      }
      if (sum > targetSum) break;
    }
  }
  throw StateError("no summation sequence found!");
}

/// Add together the smallest and largest number in the list
int calculateAnswer(List<int> xs) {
  int min = 1000000000;
  int max = 0;

  xs.forEach((x) { 
    if (x < min) min = x;
    if (x > max) max = x;
  });

  return min + max;
}