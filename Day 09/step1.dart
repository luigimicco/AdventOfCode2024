import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  String row = rows[0];

  List<List<int>> disk = [];
  for (var i = 0; i < row.length; i = i + 2) {
    int block = int.parse(row.substring(i, i + 1));
    int free = 0;
    if (i + 1 < row.length) free = int.parse(row.substring(i + 1, i + 2));
    disk.add([block, free]);
  }
  print(disk);

  List<String> space = [];
  for (var i = 0; i < disk.length; i++) {
    for (var j = 0; j < disk[i][0]; j++) {
      space.add(i.toString());
    }
    for (var j = 0; j < disk[i][1]; j++) {
      space.add(".");
    }
  }

  int pos = space.length - 1;
  int i = 0;
  bool check = true;
  while (check) {
    String right = space[pos];
    while (right == "." && pos > i) {
      pos--;
      right = space[pos];
    }

    int left = space.indexOf(".");
    if (left >= pos) {
      check = false;
    } else {
      space[left] = right;
      space[pos] = ".";
      pos--;
    }

    //print(space.join());
  }

  int score = 0;
  for (var i = 0; i < space.length; i++) {
    if (space[i] != ".") score += i * int.parse(space[i]);
  }

  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
