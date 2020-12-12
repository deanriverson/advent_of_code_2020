import 'dart:convert';

import 'dart:io';

void main() async {
  final file = File('puzzle_1_input.txt');
  final line$ =
      file.openRead().transform(utf8.decoder).transform(LineSplitter()).map((numStr) => int.parse(numStr));

  final numSet = await line$.fold(Set<int>(), (Set<int> nums, int num) {
    nums.add(num);
    return nums;
  });

  numSet.firstWhere((n) {
    final target = 2020 - n;
    if (numSet.contains(target)) {
      print("answer is ${target * n}");
      return true;
    }
    return false;
  });
}
