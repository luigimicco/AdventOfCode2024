import 'dart:io';
import 'dart:math';

void main() {
  List<String> rows = getRows();

  int total = 0;

  rows.forEach((row) {
    List<String> parts = row.split(":");
    int value = int.parse(parts[0]);
    List<String> values = parts[1].trim().split(" ");

    List<int> numbers = [];
    values.forEach((item) {
      numbers.add(int.parse(item));
    });

    bool check = checkOperator(value, numbers);
    if (check) total += value;
  });

  print(total);
}

String dec2base3(int decimal) {
  String conv = '';
  while (decimal > 0) {
    conv = conv + (decimal % 3).toString();
    decimal = (decimal / 3).floor();
  }
  return conv;
}

bool checkOperator(int result, List<int> values) {
  int tot = values.length - 1;
  int exp;
  bool check = false;

  for (int p = 0; p < pow(3, tot) && !check; p++) {
    String bin = (dec2base3(p) + "00000000000000").substring(0, tot);
    exp = values[0];

    for (int i = 0; i < bin.length; i++) {
      if (bin.substring(i, i + 1) == "0") {
        exp = exp * values[i + 1];
      } else if (bin.substring(i, i + 1) == "1") {
        exp = exp + values[i + 1];
      } else {
        exp = int.parse(exp.toString() + values[i + 1].toString());
      }
    }
    if (result == exp) check = true;
  }

  return check;
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
