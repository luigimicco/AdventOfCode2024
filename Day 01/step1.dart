import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  for (int j = 0; j < nRows; j++) {}
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
