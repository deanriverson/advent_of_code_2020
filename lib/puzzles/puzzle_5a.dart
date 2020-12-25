import 'dart:math';

import 'package:aoc/fn_utils.dart';

import '../file_utils.dart';

const maxId = 127 * 8 + 7;

void puzzle_5a() async {
  final answer = await readLines('puzzle_5_input.txt')
      .map(splitString)
      .map(stringsToInts)
      .map(toId)
      .reduce(max);

  print('Answer to 5a is $answer');
}

void puzzle_5b() async {
  final allSeats = await readLines('puzzle_5_input.txt')
      .map(splitString)
      .map(stringsToInts)
      .map(toId)
      .fold(<int>{}, addToSet);

  var answer = 0;
  for (var i = 0; i < maxId; ++i) {
    if (!allSeats.contains(i) &&
        allSeats.contains(i - 1) &&
        allSeats.contains(i + 1)) {
      answer = i;
      break;
    }
  }

  print('Answer to 5b is $answer');
}

List<String> splitString(String str) => [str.substring(0, 7), str.substring(7)];

List<int> stringsToInts(List<String> strs) => [
      binaryNumFromString(strs[0], zeroDigit: 'F', oneDigit: 'B'),
      binaryNumFromString(strs[1], zeroDigit: 'L', oneDigit: 'R'),
    ];

int binaryNumFromString(
  String str, {
  String oneDigit,
  String zeroDigit,
}) {
  if (oneDigit != null) {
    str = str.replaceAll(oneDigit, '1');
  }
  if (zeroDigit != null) {
    str = str.replaceAll(zeroDigit, '0');
  }

  return int.tryParse(str, radix: 2);
}

int toId(List<int> input) => input[0] * 8 + input[1];
