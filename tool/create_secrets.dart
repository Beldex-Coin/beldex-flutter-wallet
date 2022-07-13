import 'dart:convert';
import 'dart:io';
import 'dart:math';


const secretsProdPath = 'tool/.secrets-prod.json';
const secretsTestPath = 'tool/.secrets-test.json';

Future<void> main() async {
  final inputPath = FileSystemEntity.typeSync(secretsProdPath) !=
      FileSystemEntityType.notFound
      ? secretsProdPath
      : secretsTestPath;

  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  await File(inputPath).writeAsString(
      jsonEncode(
          {
            'salt': getRandomString(32),
            'key': getRandomString(32),
            'walletSalt': getRandomString(8),
            'shortKey': getRandomString(24)
          }
      )
  );
}