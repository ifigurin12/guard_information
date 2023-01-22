
import 'dart:io';

void main(List<String> arguments) {
  const String keyWord = 'cargobob'; 
  // кодируемый символ = код символа + код символа ключа - на какой мы сейчас итерации
  // символ = кодируемый символ - код символа ключа + на какой мы сейчас итерации

  File fileI = File('input.txt');
  File fileOutputEncrypt = File('outputE.txt');
  File fileOutputDecrypt = File('outputD.txt');
  String inputStringText = '';
  inputStringText = fileI.readAsStringSync();
  fileOutputEncrypt.create();
  fileOutputDecrypt.create();
  fileOutputEncrypt.writeAsStringSync(encrypt(keyWord, inputStringText)); 
  inputStringText = fileOutputEncrypt.readAsStringSync();
  fileOutputDecrypt.writeAsStringSync(decrypt(keyWord, inputStringText));   
}

String encrypt(String keyWord, String text) {
  String result = '';

  int count = 0;
  for (int i = 0; i < text.length; i++)
  {
    if (count == keyWord.length - 1) {
      count = 0; 
    }
    result += String.fromCharCode(text.codeUnitAt(i) + keyWord.codeUnitAt(count) - i);
    count++;
  }
  return result; 
}
String decrypt(String keyWord, String text) {
  String result = '';

  int count = 0;
  for (int i = 0; i < text.length; i++)
  {
    if (count == keyWord.length - 1) {
      count = 0; 
    }
    result += String.fromCharCode(text.codeUnitAt(i) - keyWord.codeUnitAt(count) + i);
    count++;
  }

  return result; 
}