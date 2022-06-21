import 'package:falcon/common/command.dart';

class GoogleCommandGroup extends CommandGroup<dynamic> {
  @override
  final name = 'google';
  @override
  final description = 'Google Play Store related commands';

  GoogleCommandGroup() {
    addSubCommands([]);
  }
}
