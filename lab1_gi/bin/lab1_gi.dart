import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  const List<List<String>> alphabet = [
    ['а', 'б', 'в', 'г', 'д'],
    ['е', 'ж', 'з', 'и', 'к'],
    ['л', 'м', 'н', 'о', 'п'],
    ['р', 'с', 'т', 'у', 'ф'],
    ['х', 'ц', 'ч', 'ш', 'ы'],
    ['ь', 'э', 'ю', 'я', ',']
  ];
  File fileI = File('input.txt');
  File fileOutputEncrypt = File('outputE.txt');
  File fileOutputDecrypt = File('outputD.txt');
  String inputStringText = '';
  inputStringText = fileI.readAsStringSync();
  fileOutputEncrypt.create();
  fileOutputDecrypt.create();
  fileOutputEncrypt.writeAsStringSync(encryptString(alphabet, inputStringText)); 
  inputStringText = fileOutputEncrypt.readAsStringSync();
  fileOutputDecrypt.writeAsStringSync(decryptString(alphabet, inputStringText));   
}

String encryptString(List<List<String>> alp, String str) {
  String result = '';
  int row, column;
  for (int i = 0; i < str.length; i++) {
    row = -1;
    column = 0;
    if (str[i] == ' ') {
        result += '000';
        if (i != str.length - 1) {
          result += ' ';
        }
      }
    for (var element in alp) {
      row++;
      if (element.contains(str[i])) {
        column = element.indexOf(str[i]);
        result += decimalToBinary(row);
        result += decimalToBinary(column);
        if (i != str.length - 1) {
          result += ' ';
        }
        break;
      } 
    }
  }
  return result;
}

String decryptString(List<List<String>> alp, String str) {
  List<String> tempList = str.split(' ');
  String result = '';
  int row, column;
  for (String word in tempList) {
    if (word == '000') {
      result += ' ';
    } else {
      row = binaryToDecimal(word.substring(0, 3));
      column = binaryToDecimal(word.substring(3, 6));
      result += alp[row][column];
    }
  }
  return result;
}

String decimalToBinary(int number) {
  String tempValue = "";
  while (number != 0) {
    if (number % 2 == 0) {
      tempValue += '0';
    } else {
      tempValue += '1';
    }
    number ~/= 2;
  }
  while (tempValue.length != 3) {
    tempValue = '${tempValue}0';
  }
  String result = '';
  for (int i = tempValue.length - 1; i >= 0; i--) {
    result += tempValue[i];
  }
  return result;
}

int binaryToDecimal(String binaryNumber) {
  int number = int.parse(binaryNumber);
  int resultValue = 0, count = 0;
  while (number > 0) {
    resultValue += (number % 10) * (pow(2, count).toInt());
    number = number ~/ 10;
    count++;
  }
  return resultValue;
}
