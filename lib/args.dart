import 'package:aoc/aoc.dart';
import 'package:aoc/fn_utils.dart';
import 'package:args/args.dart';
import 'package:petitparser/parser.dart';
import 'package:petitparser/petitparser.dart';

List<List<int>> parseArgs(List<String> args) {
  if (args.isEmpty) return [];

  final parser = _createParser();

  try {
    final results = parser.parse(args);
    return _validateResults(results, parser.usage);
  } catch (e) {
    print('Error: $e');
    _printUsage(parser.usage);
    return [];
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

List<List<int>> _validateResults(ArgResults results, String usage) {
  if (results['help']) {
    _printUsage(usage);
    return [];
  }

  if (results['all']) {
    return daysCompleted.keys.map((i) => [i]).toList();
  }

  var result = results['day']
      .map((d) => List<int>.from(parseDayPair(d).value.where(isNotNull)));
  return List<List<int>>.from(result);
}

void _printUsage(String argUsage) {
  print('Run Advent of Code puzzle solutions\n');
  print('Usage: aoc -d <puzzle_name>');
  print(argUsage);
}

final dayParser =
    digit().map(int.tryParse) & anyOf('ab').optional().map(dayMapper);

int dayMapper(value) => value == null
    ? null
    : value[0] == 'a'
        ? 0
        : 1;

Result<List<dynamic>> parseDayPair(String input) => dayParser.parse(input);
