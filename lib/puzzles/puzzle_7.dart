import 'package:equatable/equatable.dart';
import 'package:petitparser/parser.dart';

import '../file_utils.dart';

class Bag extends Equatable {
  final String description;
  final String color;

  const Bag(this.description, this.color);

  @override
  List<Object> get props => [description, color];

  @override
  bool get stringify => true;
}

class ContainedBag {
  final BagNode bagNode;
  final int count;

  ContainedBag(this.bagNode, this.count);

  @override
  String toString() => '$count ${bagNode.bag}';
}

class BagNode {
  final Bag bag;
  final List<BagNode> parents = [];
  final List<ContainedBag> containedBags = [];

  BagNode(this.bag);

  void addContainedBag(BagNode bagNode, int count) {
    bagNode.parents.add(this);
    containedBags.add(ContainedBag(bagNode, count));
  }

  void visit(void Function(BagNode) cb) {
    // print('visiting $bag, parents: $parents');
    cb(this);
    for (var p in parents) {
      p.visit(cb);
    }
  }

  @override
  String toString() => bag.toString();
}

void puzzle_7a() async {
  final bagMap = <Bag, BagNode>{};

  // final testLines = [
  //   'light red bags contain 1 bright white bag, 2 muted yellow bags.',
  //   'dark orange bags contain 3 bright white bags, 4 muted yellow bags.',
  //   'bright white bags contain 1 shiny gold bag.',
  //   'muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.',
  //   'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.',
  //   'dark olive bags contain 3 faded blue bags, 4 dotted black bags.',
  //   'vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.',
  //   'faded blue bags contain no other bags.',
  //   'dotted black bags contain no other bags.',
  // ];
  // await testLines.forEach((line) => parseLine(line, bagMap));

  await readLines('puzzle_7_input.txt').forEach((line) => parseLine(line, bagMap));

  var containers = <Bag>{};
  final target = bagMap[Bag('shiny', 'gold')];
  target.visit((bn) => containers.add(bn.bag));

  print('Puzzle 7a answer is: ${containers.length - 1}');
}

void puzzle_7b() async {
  final bagMap = <Bag, BagNode>{};

  // final testLines = [
  //   'shiny gold bags contain 2 dark red bags.',
  //   'dark red bags contain 2 dark orange bags.',
  //   'dark orange bags contain 2 dark yellow bags.',
  //   'dark yellow bags contain 2 dark green bags.',
  //   'dark green bags contain 2 dark blue bags.',
  //   'dark blue bags contain 2 dark violet bags.',
  //   'dark violet bags contain no other bags.',
  // ];
  // await testLines.forEach((line) => parseLine(line, bagMap));

  await readLines('puzzle_7_input.txt').forEach((line) => parseLine(line, bagMap));

  final target = bagMap[Bag('shiny', 'gold')];
  print('Puzzle 7b answer is: ${sumContained(target) - 1}');
}

int sumContained(BagNode bn) =>
    bn.containedBags.isEmpty ? 1 : bn.containedBags.fold(1, (sum, b) => sum += b.count * sumContained(b.bagNode));

final word = letter().plus().flatten().trim();
final bagLiteral = (string('bag') & char('s').optional()).flatten();
final containLiteral = string('contain').trim();
final count = digit().plus().flatten().trim().map(int.tryParse);
final bagDescription = word & word & bagLiteral;
final contained = (count & bagDescription & anyOf(',.')).plus();
final noOtherBags = string('no other bags.');
final lineParser = bagDescription & containLiteral & (contained | noOtherBags);

void parseLine(String line, Map<Bag, BagNode> bagMap) {
  // print('processing $line');
  final resultList = lineParser.parse(line).value;
  final bag = listToBag(resultList);
  final node = getBagNodeFromMap(bagMap, bag);

  processContainedBags(node, resultList, bagMap);
}

BagNode getBagNodeFromMap(Map<Bag, BagNode> bagMap, Bag bag) => bagMap.putIfAbsent(bag, () => BagNode(bag));

void processContainedBags(BagNode node, List resultList, Map<Bag, BagNode> bagMap) {
  var containedClause = resultList[4];
  if (containedClause is String) return;

  for (var result in containedClause) {
    final count = result[0];
    final bag = listToBag(result[1]);
    final bagNode = getBagNodeFromMap(bagMap, bag);
    node.addContainedBag(bagNode, count);
  }
}

Bag listToBag(List l) => Bag(l[0].toString(), l[1].toString());
