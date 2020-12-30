import 'dart:math' as math;

import 'package:aoc/puzzles/puzzle_1a.dart';
import 'package:aoc/puzzles/puzzle_1b.dart';
import 'package:aoc/puzzles/puzzle_25a.dart';
import 'package:aoc/puzzles/puzzle_2a.dart';
import 'package:aoc/puzzles/puzzle_2b.dart';
import 'package:aoc/puzzles/puzzle_3a.dart';
import 'package:aoc/puzzles/puzzle_3b.dart';
import 'package:aoc/puzzles/puzzle_4a.dart';
import 'package:aoc/puzzles/puzzle_4b.dart';
import 'package:aoc/puzzles/puzzle_5.dart';
import 'package:aoc/puzzles/puzzle_6.dart';
import 'package:aoc/puzzles/puzzle_7.dart';
import 'package:aoc/puzzles/puzzle_8.dart';
import 'package:aoc/puzzles/puzzle_9a.dart';
import 'package:aoc/puzzles/puzzle_9b.dart';

const daysCompleted = <int, List<Function>>{
  1: [puzzle_1a, puzzle_1b],
  2: [puzzle_2a, puzzle_2b],
  3: [puzzle_3a, puzzle_3b],
  4: [puzzle_4a, puzzle_4b],
  5: [puzzle_5a, puzzle_5b],
  6: [puzzle_6a, puzzle_6b],
  7: [puzzle_7a, puzzle_7b],
  8: [puzzle_8a, puzzle_8b],
  9: [puzzle_9a, puzzle_9b],
  25: [puzzle_25a],
};

int maxDaysCompleted({Map<int, List<Function>> entries = daysCompleted}) => entries.keys.reduce(math.max);

void runPuzzles(List<List<int>> puzzles) {
  if (puzzles.isEmpty) {
    final day = maxDaysCompleted();
    final puzzle = daysCompleted[day].last;
    puzzle();
  }

  for (var p in puzzles) {
    if (p.length == 1) {
      runAllPuzzlesForDay(p[0]);
    } else {
      runPuzzleForDayAtIndex(p[0], p[1]);
    }
  }
}

void runPuzzle(Function p) => p();

void runAllPuzzlesForDay(int day) => daysCompleted[day].forEach(runPuzzle);

void runPuzzleForDayAtIndex(int day, int index) => runPuzzle(daysCompleted[day][index]);
