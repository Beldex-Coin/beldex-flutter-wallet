import 'dart:convert';
import 'dart:io';

const secretsProdPath = 'tool/.secrets-prod.json';
const secretsTestPath = 'tool/.secrets-test.json';
const outputPath = 'lib/.secrets.g.dart';

const legacyV1Secrets = {
  'salt': '',
  'key': '',
  'walletSalt': '',
  'shortKey': '',
};

Future<void> main() async {
  final inputPath = FileSystemEntity.typeSync(secretsProdPath) !=
      FileSystemEntityType.notFound
      ? secretsProdPath
      : secretsTestPath;

  final config =
  json.decode(File(inputPath).readAsStringSync()) as Map<String, dynamic>;

  String requireKey(String name) {
    final value = config[name];
    if (value == null) {
      stderr.writeln(
          'ERROR: "$name" missing from $inputPath. Run `dart tool/create_secrets.dart` first.');
      exit(1);
    }
    return value as String;
  }

  final buffer = StringBuffer()
    ..writeln('// GENERATED FILE — do not edit and do not commit.')
    ..writeln("const salt = '${legacyV1Secrets['salt']}';")
    ..writeln("const key = '${legacyV1Secrets['key']}';")
    ..writeln("const walletSalt = '${legacyV1Secrets['walletSalt']}';")
    ..writeln("const shortKey = '${legacyV1Secrets['shortKey']}';")
    ..writeln("const salt_v2 = '${requireKey('salt_v2')}';")
    ..writeln("const key_v2 = '${requireKey('key_v2')}';")
    ..writeln("const walletSalt_v2 = '${requireKey('walletSalt_v2')}';")
    ..writeln("const shortKey_v2 = '${requireKey('shortKey_v2')}';");

  await File(outputPath).writeAsString(buffer.toString());
}
