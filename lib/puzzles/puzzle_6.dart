import 'package:rxdart/rxdart.dart';

import '../file_utils.dart';
import '../fn_utils.dart';

const maxId = 127 * 8 + 7;

void puzzle_6a() async {
  final answer = await readLines('puzzle_6_input.txt')
      .bufferTest((line) => line.isEmpty)
      .map(toSet)
      .map(toLength)
      .reduce(sum);

  print('Answer to 6a is $answer');
}

void puzzle_6b() async {
  final answer = await readLines('puzzle_6_input.txt')
      .bufferTest((line) => line.isEmpty)
      .map(toSetList)
      .map(intersect)
      .map(toLength)
      .reduce(sum);

  print('Answer to 6b is $answer');
}

int toLength(Iterable a) => a.length;

int sum(int a, int b) => a + b;

List<String> splitChars(String str) => str.split('').toList();

Set<String> toSet(List<String> input) {
  return input
      .where((it) => it.isNotEmpty)
      .map(splitChars)
      .expand(identity)
      .toSet();
}

List<Set<String>> toSetList(List<String> input) {
  return input
      .where((it) => it.isNotEmpty)
      .map(splitChars)
      .map((l) => l.toSet())
      .toList();
}

Set<String> intersect(List<Set<String>> list) =>
    list.reduce((a, b) => a.intersection(b));

