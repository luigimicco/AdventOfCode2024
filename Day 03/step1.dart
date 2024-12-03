import 'dart:io';

void main() {
  String row = getRow();

  RegExp exp = RegExp(r'mul\((\d{1,3}),(\d{1,3})\)');
  Iterable<RegExpMatch> matches = exp.allMatches(row);

  int score = 0;
  for (final m in matches) {
    score = score +
        int.parse(m[1].toString().toString()) *
            int.parse(m[2].toString().toString());
  }
  print(score);
}

String getRow() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent;
}
