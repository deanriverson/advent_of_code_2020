import 'package:aoc/args.dart';
import 'package:test/test.dart';

void main() {
  group('day parser', () {
    test('day and letter is accepted', () {
      expect(parseDayPair('9a').isSuccess, isTrue);
      expect(parseDayPair('3b').isSuccess, isTrue);
    });

    test('letter is optional', () {
      expect(parseDayPair('9').value, equals([9, null]));
      expect(parseDayPair('3').value, equals([3, null]));
    });

    test('only a and b are allowed letters', () {
      expect(parseDayPair('1a').value, equals([1, 0]));
      expect(parseDayPair('4b').value, equals([4, 1]));
      expect(parseDayPair('6c').value, equals([6, null]));
    });
  });

  test('--day option parses correction', () {
    expect(parseArgs(['--day', '1']), [
      [1]
    ]);

    expect(parseArgs(['--day=3a']), [
      [3, 0]
    ]);

    expect(parseArgs(['-d', '2']), [
      [2]
    ]);

    expect(parseArgs(['-d9b']), [
      [9, 1]
    ]);
  });
}
