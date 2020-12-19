import '../file_utils.dart';

typedef TreeFolder = int Function(int, List<int>);

void puzzle_3b() async {
  final lines = await readLines('puzzle_3_input.txt').toList();
  final slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ];

  final answer = slopes.fold(1, productOfTrees(lines));
  print('Puzzle 3b answer is: $answer');
}

TreeFolder productOfTrees(lines) => (total, slope) => total *= countTrees(lines, slope);

int countTrees(List<String> terrainList, List<int> slope) {
  assert(terrainList.length > 1);
  assert(slope.length == 2);

  final right = slope[0];
  final down = slope[1];

  final lineLen = terrainList[0].length;
  final terrain = terrainList.join();

  var loc = 0;
  var trees = 0;
  var lineIdx = 0;

  while (loc < terrain.length) {
    trees += isTreeAtLoc(terrain, loc) ? 1 : 0;

    final nextLineIdx = (lineIdx + right) % lineLen;
    final yMod = didOverflow(lineIdx, nextLineIdx) ? 1 : 0;

    loc += lineLen * (down - yMod) + right;
    lineIdx = nextLineIdx;
  }
  return trees;
}

bool isTreeAtLoc(String terrain, int loc) => terrain[loc] == '#';

bool didOverflow(int last, int next) => next < last;
