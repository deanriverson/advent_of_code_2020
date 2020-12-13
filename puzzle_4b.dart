import 'file_utils.dart';
import 'package:rxdart/rxdart.dart';

const byr = "byr";
const iyr = "iyr";
const eyr = "eyr";
const hgt = "hgt";
const hcl = "hcl";
const ecl = "ecl";
const pid = "pid";

void main() async {
  final emptyLine = [Stream.value("")];

  final answer = await readLines('puzzle_4_input.txt')
      .concatWith(emptyLine)
      .map(parseKeyValues)
      .scan(passportScanner, <String, dynamic>{})
      .where(isValid)
      .fold(0, (t, _) => t+1);

  print('answer is $answer');
}

final regex = RegExp(r"([a-zA-Z]{3}):(\S+)");

Map<String, dynamic> parseKeyValues(String line) => 
  regex.allMatches(line)
    .fold(<String, dynamic>{}, matchToKeyValue);

Map<String, dynamic> matchToKeyValue(kvs, match) {
  kvs[match.group(1)] = match.group(2);
  return kvs;
}

Map<String, dynamic> passportScanner(Map<String, dynamic> kvs, newKvs, _) {
  if (kvs.containsKey("complete")) {
    return newKvs;
  }

  if (newKvs.isEmpty) {
    kvs["complete"] = true;
    return kvs;
  }

  kvs.addAll(newKvs);
  return kvs;
}

bool isValid(Map<String, dynamic> kvs) =>
  kvs.containsKey("complete") &&
  isByrValid(kvs[byr]) &&
  isIyrValid(kvs[iyr]) &&
  isEyrValid(kvs[eyr]) &&
  isHgtValid(kvs[hgt]) &&
  isHclValid(kvs[hcl]) &&
  isEclValid(kvs[ecl]) &&
  isPidValid(kvs[pid]);

bool Function(String) isByrValid = chain2(parseAsInt, isBetween(1920, 2002));
bool Function(String) isIyrValid = chain2(parseAsInt, isBetween(2010, 2020));
bool Function(String) isEyrValid = chain2(parseAsInt, isBetween(2020, 2030));

bool Function(String) isHclValid = createRegExpValidator(RegExp(r"#([0-9a-f]{6})"));
bool Function(String) isPidValid = createRegExpValidator(RegExp(r"^([0-9]{9})$"));

final validEcls = { 'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth' };
bool isEclValid(String val) => validEcls.contains(val);

final cmRegExp = RegExp(r"(\d+)cm");
final inRegExp = RegExp(r"(\d+)in");

final cmBetween = chain2(parseAsInt, isBetween(150, 193));
final inBetween = chain2(parseAsInt, isBetween(59, 76));

bool isHgtValid(String val) {
  if (val == null) {
    return false;
  }

  final cmMatches = cmRegExp.allMatches(val);
  final inMatches = inRegExp.allMatches(val);

  if (cmMatches.length == 0 && inMatches.length == 0) {
    return false;
  }

  return (cmMatches.length > 0)
    ? cmBetween(cmMatches.first.group(1))
    : inBetween(inMatches.first.group(1));
}
