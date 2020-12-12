import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('puzzle_1_input.txt');
  final line$ = file.openRead().transform(utf8.decoder).transform(LineSplitter()).map((numStr) => int.parse(numStr));

  final numSet = await line$.fold(Set<int>(), setReducer);

  numSet.firstWhere((first) {
    final setMinus = Set.of(numSet);
    setMinus.remove(first);

    final second = setMinus.firstWhere(createTargetFinder(numSet, first), orElse: () => null);

    if (second != null) {
      print("The answer is ${first * second * (2020 - first - second)}");
      return true;
    }

    return false;
  });
}

Set<int> setReducer(Set<int> nums, int num) {
  nums.add(num);
  return nums;
}

bool Function(int) createTargetFinder(Set<int> numSet, int first) =>
    (int second) => numSet.contains(2020 - first - second);
