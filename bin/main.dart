import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';

Map<String, Set> finalFile = Map();

void csvToMap1(String path) {
  String str = new File(path).readAsStringSync().replaceAll('"', '');

  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(str, fieldDelimiter: ';');

  for (int i = 1; i < rowsAsListOfValues.length; i++) {
    if (!finalFile.containsKey(rowsAsListOfValues[i][1]))
      finalFile[rowsAsListOfValues[i][1]] = {rowsAsListOfValues[i][2]};
    else {
      finalFile[rowsAsListOfValues[i][1]].add(rowsAsListOfValues[i][2]);
    }
  }
}

void csvToMap2(String path) {
  String str = new File(path).readAsStringSync();

  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(str, fieldDelimiter: ';');
  int count = 0;
  for (int i = 1; i < rowsAsListOfValues.length; i++) {
    for (int j = 0; j < rowsAsListOfValues[i].length; j++) {
      String s = rowsAsListOfValues[i][j].toString();
      List list = s.split("_");
      rowsAsListOfValues[i][j] = list.last;
    }
  }

  for (int i = 1; i < rowsAsListOfValues.length; i++) {
    if (rowsAsListOfValues[i][0] == '') {
      rowsAsListOfValues[i][0] = rowsAsListOfValues[count][0];
    } else {
      count = i;
    }
    if (!finalFile.containsKey(rowsAsListOfValues[i][0]))
      finalFile[rowsAsListOfValues[i][0]] = {rowsAsListOfValues[i][2]};
    else {
      finalFile[rowsAsListOfValues[i][0]].add(rowsAsListOfValues[i][2]);
    }
  }
}

void csvToMap3(String path) {
  String str = new File(path).readAsStringSync().replaceAll('"', '');

  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(str, fieldDelimiter: ';');

  for (int i = 1; i < rowsAsListOfValues.length; i++) {
    for (int j = 1; j < rowsAsListOfValues[i].length; j++) {
      if (!finalFile.containsKey(rowsAsListOfValues[i][0]))
        finalFile[rowsAsListOfValues[i][0]] = {rowsAsListOfValues[i][j]};
      else {
        finalFile[rowsAsListOfValues[i][0]].add(rowsAsListOfValues[i][j]);
      }
    }
  }
}

void csvToMap4(String path) {
  String str = new File(path).readAsStringSync().replaceAll('"', '');

  List<List<dynamic>> rowsAsListOfValues =
      const CsvToListConverter().convert(str, fieldDelimiter: ';');

  for (int i = 1; i < rowsAsListOfValues.length; i++) {
    for (int j = 1; j < rowsAsListOfValues[i].length; j++) {
      if (rowsAsListOfValues[i][j] == 1) {
        if (!finalFile.containsKey(rowsAsListOfValues[i][133]))
          finalFile[rowsAsListOfValues[i].last] = {rowsAsListOfValues[0][j]};
        else {
          finalFile[rowsAsListOfValues[i].last].add(rowsAsListOfValues[0][j]);
        }
      }
    }
  }
}

Future<void> convertCsv() async {
  String finalFileContent = '';

  int num = 0;
  for (var item in finalFile.entries) {
    finalFileContent += '${item.key}, ${item.value.join(", ")}\n';
    File('assets/finalFile.csv').writeAsStringSync(finalFileContent);
    num++;
    print('$num, out of ${finalFile.length}');
  }
}

Future<void> main() async {
  csvToMap1('assets/1.csv');
  csvToMap2('assets/2.csv');
  csvToMap3('assets/3.csv');
  csvToMap4('assets/4.csv');

  await convertCsv();
}
