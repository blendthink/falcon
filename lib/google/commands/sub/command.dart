import 'package:falcon/common/command.dart';
import 'package:falcon/google/commands/sub/options/key_path.dart';

abstract class GoogleSubcommand extends Subcommand {
  GoogleSubcommand(super.options) {
    options.add(KeyPathOption());
    addOptions();
  }
}
