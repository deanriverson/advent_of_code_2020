import 'dart:convert';
import 'dart:io';

Stream<String> readLines(String filePath) => 
  File(filePath)
    .openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter());