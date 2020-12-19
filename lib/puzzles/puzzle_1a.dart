
import 'package:aoc/file_utils.dart';

void puzzle_1a() async {
  final line$ = readLines('puzzle_1_input.txt').map((numStr) => int.parse(numStr));

  final numSet = await line$.fold(<int>{}, (Set<int> nums, int num) {
    nums.add(num);
    return nums;
  });

  numSet.firstWhere((n) {
    final target = 2020 - n;
    if (numSet.contains(target)) {
      print('Puzzle 1a answer is: ${target * n}');
      return true;
    }
    return false;
  });
}
