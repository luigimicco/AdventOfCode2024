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

  left.sort();
  right.sort();

  int total = 0;
  for (int j = 0; j < nRows; j++) {
    total = total + (left[j] - right[j]).abs();
  }
  print(total);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
