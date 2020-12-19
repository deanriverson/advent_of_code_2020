import 'package:aoc/aoc.dart';
import 'package:args/args.dart';

List<String> parseArgs(List<String> args) {
  if (args.isEmpty) return [];

  final parser = _createParser();

  try {
    final results = parser.parse(args);
    return _validateResults(results, parser.usage);
  } catch (_) {
    _printUsage(parser.usage);
    return null;
  }
}

ArgParser _createParser() {
  final parser = ArgParser();

  parser.addMultiOption(
    'day',
    abbr: 'd',
    help: '''Puzzle name to run (default is to run last puzzle completed):
      1a = run the first puzzle for day 1
      2  = run both puzzles for day 2
      7b = run the second puzzle for day 7
    ''',
  );

  parser.addFlag(
    'all',
    abbr: 'a',
    negatable: false,
    help: 'Run all puzzle solutions',
  );

  parser.addFlag(
    'help',
    abbr: 'h',
    negatable: false,
    help: 'Displays this usage information',
  );

  return parser;
}

List<String> _validateResults(ArgResults results, String usage) {
  if (results['help']) {
    _printUsage(usage);
    return null;
  }

  if (results['all']) {
    return daysCompleted.keys.map((i) => i.toString()).toList();
  }

  return [];
}

void _printUsage(String argUsage) {
  print('Run Advent of Code puzzle solutions\n');
  print('Usage: aoc -d <puzzle_name>');
  print(argUsage);
}
