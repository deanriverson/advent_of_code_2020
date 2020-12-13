import 'dart:convert';
import 'dart:io';

Stream<String> readLines(String filePath) => 
  File(filePath)
    .openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter());

int parseAsInt(String val) => val == null ? -1 : int.tryParse(val) ?? -1;

bool Function(int) isBetween(int min, int max) => (int val) => min <= val && val <= max;

Function chain2<X, Y, R>(Y Function(X) fn1, R Function(Y) fn2) => (X val) => fn2(fn1(val));

bool Function(String) createRegExpValidator(RegExp regExp) => (String val) => val == null ? false : regExp.hasMatch(val);