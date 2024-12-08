import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int score = 0;

  List<List<int>> antinodes = [];
  for (var i = 0; i < nRows; i++) {
    antinodes.add([]);
    for (var j = 0; j < rows[i].trim().length; j++) {
      antinodes[i].add(0);
    }
  }

  for (var i = 0; i < nRows; i++) {
    String row = rows[i].trim();
    for (var j = 0; j < row.length; j++) {
      score += checkNeighbours(rows, antinodes, i, j);
    }
  }

  for (var i = 0; i < antinodes.length; i++) {
    String line = i.toString() + "  ";

    for (var j = 0; j < antinodes[i].length; j++) {
      line = line + (antinodes[i][j] == 1 ? "#" : ".");
    }
    print(line);
  }

  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}

int checkNeighbours(
    List<String> rows, List<List<int>> antinodes, int row, int col) {
  String antenna = "";

  int newAntinodes = 0;

  int len = rows[row].trim().length;
  antenna = rows[row].substring(col, col + 1);

  if (antenna != ".") {
    bool border = false;

    int posC = col;
    int posR = row;

    int dist = 1;
    while (dist < 50) {
      String check = "";

      for (var posR = row - dist; posR <= row + dist; posR++) {
        if (!(posR >= 0 && posR < rows.length)) continue;
        for (var posC = col - dist; posC <= col + dist; posC++) {
          if (!(posC >= 0 && posC < len)) continue;
          if (posR == row && posC == col) continue;

          check = rows[posR].substring(posC, posC + 1);

          if (check == antenna) {
            int dC = 0;
            int dR = 0;

            int antC = 0;
            int antR = 0;
            antC = posC + (posC - col);
            antR = posR + (posR - row);

            dC = antC - posC;
            dR = antR - posR;

            for (var i = 0; i < 50; i++) {
              if ((antC >= 0 && antC < len) &&
                  (antR >= 0 && antR < rows.length)) {
                if (antinodes[antR][antC] == 0) {
                  antinodes[antR][antC] = 1;
                  newAntinodes++;
                }
                ;
              }
              antC = antC - dC;
              antR = antR - dR;
            }
          }
        }
      }

      dist++;
    }
  }
  return newAntinodes;
}
