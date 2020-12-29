import 'package:aoc/puzzles/puzzle_7.dart';
import 'package:test/test.dart';

void main() {
  group('Bag', () {
    test('is equatable', () {
      final lightRedBag1 = Bag('light', 'red');
      final lightRedBag2 = Bag('light', 'red');
      final mutedYellowBag = Bag('muted', 'yellow');

      expect(lightRedBag1, equals(lightRedBag2));
      expect(lightRedBag1, isNot(equals(mutedYellowBag)));
    });

    test('is hashable', () {
      final bagSet = <Bag>{
        Bag('light', 'red'),
        Bag('light', 'red'),
        Bag('muted', 'yellow'),
      };

      expect(bagSet.length, 2);
    });
  });

  group('Parser', () {
    test('can parse color and description', () {
      expect(
        bagDescription.parse('light red bags').value,
        ['light', 'red', 'bags'],
      );
      expect(
        bagDescription.parse('dark orange bags').value,
        ['dark', 'orange', 'bags'],
      );
      expect(
        bagDescription.parse('shiny gold bag').value,
        ['shiny', 'gold', 'bag'],
      );
    });

    test('parses contain literal', () {
      expect(containLiteral.parse('contain').value, 'contain');
      expect(containLiteral.parse(' contain ').value, 'contain');
    });

    test('parses contained bags', () {
      final oneDarkOliveBag = [
        1,
        ['dark', 'olive', 'bag'],
        ','
      ];

      final twoVibrantPlumBags = [
        2,
        ['vibrant', 'plum', 'bags'],
        '.'
      ];

      expect(contained.parse('1 dark olive bag,').value, [oneDarkOliveBag]);

      expect(
        contained.parse('1 dark olive bag, 2 vibrant plum bags.').value,
        [oneDarkOliveBag, twoVibrantPlumBags],
      );

      expect(contained.parse('22 vibrant plum bags.').value, [
        [
          22,
          ['vibrant', 'plum', 'bags'],
          '.'
        ]
      ]);
    });

    test('parses lines', () {
      final input = 'light red bags contain 1 bright white bag, 2 muted yellow bags.';
      final expected = [
        'light',
        'red',
        'bags',
        'contain',
        [
          [
            1,
            ['bright', 'white', 'bag'],
            ','
          ],
          [
            2,
            ['muted', 'yellow', 'bags'],
            '.'
          ]
        ]
      ];
      expect(lineParser.parse(input).value, expected);
    });

    test('parses terminal lines', () {
      final input = 'faded blue bags contain no other bags.';
      final expected = ['faded', 'blue', 'bags', 'contain', 'no other bags.'];
      expect(lineParser.parse(input).value, expected);
    });
  });

  test('listToBag', () {
    expect(listToBag(['bright', 'white', 'bag']), Bag('bright', 'white'));
    expect(listToBag(['faded', 'blue', 'bags', 'contain', 'no other bags.']), Bag('faded', 'blue'));
  });
}
