import 'dart:io';

void main() {
  List<String> rows = getRows();

  for (int j = 0; j < rows.length; j++) {}
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
