import 'dart:io';

void main() {
  String row = getRow();

  RegExp exp = RegExp(r"mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)");
  Iterable<RegExpMatch> matches = exp.allMatches(row);

  int score = 0;
  bool skip = false;
  for (final m in matches) {
    String match = m[0].toString().substring(0, 3);

    if (match == "don") {
      skip = true;
    } else if (match == "do(") {
      skip = false;
    } else {
      if (!skip)
        score = score +
            int.parse(m[1].toString().toString()) *
                int.parse(m[2].toString().toString());
    }
  }
  print(score);
}

String getRow() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent;
}
