import 'dart:math' as math;

import 'package:aoc/file_utils.dart';
import 'package:aoc/puzzles/puzzle_1a.dart';
import 'package:aoc/puzzles/puzzle_1b.dart';
import 'package:aoc/puzzles/puzzle_2a.dart';
import 'package:aoc/puzzles/puzzle_2b.dart';
import 'package:aoc/puzzles/puzzle_3a.dart';
import 'package:aoc/puzzles/puzzle_3b.dart';
import 'package:aoc/puzzles/puzzle_4a.dart';
import 'package:aoc/puzzles/puzzle_4b.dart';
import 'package:aoc/puzzles/puzzle_9a.dart';
import 'package:aoc/puzzles/puzzle_9b.dart';

const daysCompleted = <int, List<Function>>{
  1: [puzzle_1a, puzzle_1b],
  2: [puzzle_2a, puzzle_2b],
  3: [puzzle_3a, puzzle_3b],
  4: [puzzle_4a, puzzle_4b],
  9: [puzzle_9a, puzzle_9b],
};

int maxDaysCompleted({Map<int, List<Function>> entries = daysCompleted}) => entries.keys.reduce(math.max);

void runPuzzles(List<String> puzzles) {
  if (puzzles.isEmpty) {
    final day = maxDaysCompleted();
    final puzzle = daysCompleted[day].last;
    puzzle();
  }

  puzzles.forEach((d) => daysCompleted[parseAsInt(d)].forEach((p) => p()));
}
