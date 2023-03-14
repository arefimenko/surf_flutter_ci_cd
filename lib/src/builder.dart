import 'dart:io';

import 'package:surf_flutter_ci_cd/src/enums/enums.dart';
import 'package:surf_flutter_ci_cd/src/util/printer.dart';

Future<void> buildAndroidOutput({
  required String flavor,
  required String buildType,
  required String entryPointPath,
  required String projectName,
  required String flags,
  PublishingFormat format = PublishingFormat.appbundle,
}) async {
  exitCode = 0;
  Printer.printWarning(
    'Build type: $buildType, Format: $format, Flavor: $flavor, Target: $entryPointPath',
  );
  try {
    final result = await Process.run(
      'flutter',
      [
        'build',
        format.format,
        '-t',
        entryPointPath,
        '--flavor',
        flavor,
        flags,
      ],
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  } on Object catch (e) {
    Printer.printError(e.toString());
    exit(1);
  }
}

Future<void> buildIosOutput({
  required String flavor,
  required String buildType,
  required String entryPointPath,
}) async {
  exitCode = 0;

  try {
    Printer.printWarning(
        'Build type: $buildType, Format: ipa, Flavor: $flavor');

    final result = await Process.run('fvm', [
      'flutter',
      'build',
      'ipa',
      '-t',
      entryPointPath,
      '--flavor',
      flavor,
      '--release',
    ]);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  } on Object catch (e) {
    Printer.printError(e.toString());
    exit(1);
  }
}
