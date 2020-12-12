import 'file_utils.dart';

void main() async {
  final lines = await readLines('puzzle_3_input.txt').toList();
  final answer = traverseMap(lines, 3, 1);
  print('answer is $answer');
}

int traverseMap(List<String> terrainList, int right, int down) {
  assert(terrainList.length > 1);

  final lineLen = terrainList[0].length;
  final span = lineLen * down + right;
  final terrain = terrainList.join();

  int loc = 0;
  int trees = 0;
  int lineIdx = 0;

  while (loc < terrain.length) {
    trees += isTreeAtLoc(terrain, loc) ? 1 : 0;
    
    final nextLineIdx = (lineIdx + right) % lineLen;
    loc += didOverflow(lineIdx, nextLineIdx) ? right : span;
    lineIdx = nextLineIdx;
  }
  return trees;
}

bool isTreeAtLoc(String terrain, int loc) => terrain[loc] == '#';

bool didOverflow(int last, int next) => next < last;