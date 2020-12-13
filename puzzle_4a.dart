import 'file_utils.dart';
import 'package:rxdart/rxdart.dart';

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
  kvs.containsKey("byr") &&
  kvs.containsKey("iyr") &&
  kvs.containsKey("eyr") &&
  kvs.containsKey("hgt") &&
  kvs.containsKey("hcl") &&
  kvs.containsKey("ecl") &&
  kvs.containsKey("pid");
