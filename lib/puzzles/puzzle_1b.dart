
import '../file_utils.dart';

void puzzle_1b() async {
  final line$ = readLines('puzzle_1_input.txt').map((numStr) => int.parse(numStr));

  final numSet = await line$.fold(<int>{}, setReducer);

  numSet.firstWhere((first) {
    final setMinus = Set.of(numSet);
    setMinus.remove(first);

    final second = setMinus.firstWhere(createTargetFinder(numSet, first), orElse: () => null);

    if (second != null) {
      print('Puzzle 1b answer is: ${first * second * (2020 - first - second)}');
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
