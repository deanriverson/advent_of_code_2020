import 'package:aoc/args.dart';
import 'package:test/test.dart';

void main() {
  test('--day option parses correction', () {
    expect(parseArgs(['--day', '1']), ['1']);
    expect(parseArgs(['--day=3a']), ['3a']);

    expect(parseArgs(['-d', '2']), ['2']);
    expect(parseArgs(['-d9b']), ['9b']);
  });

  group('day parser', () {
    test('day and letter is accepted', () {
      expect(parseDayPair('9a').isSuccess, isTrue);
      expect(parseDayPair('3b').isSuccess, isTrue);
    });

    test('letter is optional', () {
      expect(parseDayPair('9').isSuccess, isTrue);
      expect(parseDayPair('3').isSuccess, isTrue);
    });

    test('only a and b are allowed letters', () {
      expect(parseDayPair('1a').isSuccess, isTrue);
      expect(parseDayPair('4b').isSuccess, isTrue);
      expect(parseDayPair('6c').isSuccess, isFalse);
    });
  });

  group('day format parses correctly', () {
    test('plain numbers are accepted', () {
      expect(parseArgs(['--day', '1']), ['1']);
    });
  });
}
