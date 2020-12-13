import 'file_utils.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  const preambleSize = 25;

  readLines('puzzle_5_input.txt')
    .map(parseAsInt)
    .bufferCount(preambleSize + 1, 1)
    .map(processBuffer)
    .listen((x) => print('${x} is valid'), 
      onError: (e) => print("Found one: $e"), 
      cancelOnError: true);
}

int processBuffer(List<int> buffer) {
  final sum = buffer.last;
  final set = buffer.sublist(0, buffer.length - 1).toSet();

  final result = set.any((el) {
    final target = sum - el;
    return target != el && set.contains(target);
  });

  if (!result) {
    throw StateError("$sum is not valid!");
  }

  return sum;
}
