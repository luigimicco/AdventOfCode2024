import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  List<int> left = [];
  List<int> right = [];
  for (int j = 0; j < nRows; j++) {
    String row = rows[j];
    List<String> parts = row.split("   ");
    left.add(int.parse(parts[0]));
    right.add(int.parse(parts[1]));
  }

  int score = 0;
  for (int j = 0; j < nRows; j++) {
    var similarity = right.where((item) => item == left[j]);

    score = score + left[j] * similarity.length;
  }
  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
