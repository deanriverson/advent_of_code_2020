import 'package:aoc/aoc.dart';
import 'package:aoc/args.dart';

void main(List<String> arguments) {
  final puzzlesToRun = parseArgs(arguments);
  if (puzzlesToRun.isEmpty) return;

  runPuzzles(puzzlesToRun);
}
