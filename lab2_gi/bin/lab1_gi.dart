import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

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
  File fileOutputEncrypt = File('outputE.bin');
  File fileOutputDecrypt = File('outputD.txt');
  String inputStringText = '';
  inputStringText = fileI.readAsStringSync();
  fileOutputEncrypt.create();
  fileOutputDecrypt.create();
  fileOutputEncrypt.writeAsBytesSync(encryptString(alphabet, inputStringText)); 
  List<int> encryptInt = fileOutputEncrypt.readAsBytesSync();
  //print(encryptInt);
  //print(decimalToBinary(93));
  fileOutputDecrypt.writeAsStringSync(decryptString(alphabet, encryptInt));   
}

List<int> encryptString(List<List<String>> alp, String str) {
  List<int> result = [];
  int row, column;
  for (int i = 0; i < str.length; i++) {
    row = -1;
    column = 0;
    if (str[i] == ' ') {
        result.add(000);
      }
    for (var element in alp) {
      row++;
      if (element.contains(str[i])) {
        column = element.indexOf(str[i]);
        result.add(int.parse(decimalToBinary(row + 1)));
        result.add(int.parse(decimalToBinary(column + 1)));
        break;
      } 
    }
  }
  return result;
}

String decryptString(List<List<String>> alp, List<int> numbers) {
  String strEncrypt = listIntToStringBinary(numbers);
  String result = '';
  int row, column;
  int index = 0;
  while (strEncrypt.length >= index + 3) {
    if (strEncrypt.substring(index, index + 3) == '000') {
      result += ' ';
      index += 3;
    } else if (strEncrypt.substring(index, index + 3) != '000'){
      row = binaryToDecimal(strEncrypt.substring(index, index + 3)) - 1;
      column = binaryToDecimal(strEncrypt.substring(index + 3, index + 6)) - 1;
      result += alp[row][column];
      index += 6;
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

String listIntToStringBinary(List<int> input) 
{
  String result = '', temp;
  for(int item in input) 
  {
    temp = item.toString();
    while(temp.length < 3) 
    {
      temp = '0' + temp;
    }
    result += temp;
  }
  return result;
}