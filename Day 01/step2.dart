import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  List<int> left = [];
  List<int> right = [];
  rows.forEach((row) {
    List<String> parts = row.split("   ");
    left.add(int.parse(parts[0]));
    right.add(int.parse(parts[1]));
  });

  int score = 0;
  left.forEach((row) {
    var similarity = right.where((item) => item == row);
    score = score + row * similarity.length;
  });

  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
