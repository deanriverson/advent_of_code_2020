import 'package:aoc/args.dart';
import 'package:test/test.dart';

void main() {
  test('--day option parses correction', () {
    expect(parseArgs(['--day', '1']), ['1']);
    expect(parseArgs(['--day=3a']), ['3a']);

    expect(parseArgs(['-d', '2']), ['2']);
    expect(parseArgs(['-d9b']), ['9b']);
  });

  group('day format parses correctly', () {
    test('plain numbers are accepted', () {
      expect(parseArgs(['--day', '1']), ['1']);
    });
  });
}
