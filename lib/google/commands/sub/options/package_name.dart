import 'package:args/args.dart' show ArgResults;
import 'package:falcon/common/command.dart';
import 'package:falcon/common/option.dart';

class PackageNameOption extends Option {
  static const _name = 'packageName';

  PackageNameOption()
      : super(
          _name,
          abbr: 'p',
          help: 'set package name',
          mandatory: true,
        );

  static String packageName(
    ArgResults argResults,
    Never Function(String message) usageException,
  ) {
    final packageName = argResults.requireParam<String>(_name);
    if (packageName.isEmpty) {
      usageException('$_name is Empty');
    }
    return packageName;
  }
}
