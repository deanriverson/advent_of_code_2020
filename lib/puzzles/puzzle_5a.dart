import 'dart:math';

import '../file_utils.dart';

void puzzle_5a() async {
  final answer = await readLines('puzzle_5_input.txt')
      .map(splitString)
      .map(stringsToInts)
      .map(toId)
      .reduce(max);

  print('Answer to 5a is $answer');
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
