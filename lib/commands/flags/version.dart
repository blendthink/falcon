import 'package:falcon/common/option.dart';

class VersionFlag extends Flag {
  static const _name = 'version';

  VersionFlag()
      : super(
          _name,
          abbr: 'v',
          help: 'Print the falcon version.',
          negatable: false,
        );
}
