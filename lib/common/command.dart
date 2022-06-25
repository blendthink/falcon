import 'package:args/args.dart' show ArgResults;
import 'package:args/command_runner.dart';
import 'package:falcon/common/option.dart';

abstract class CommandGroup<T extends Subcommand> extends Command {
  void addSubcommands(List<T> commands) {
    for (final command in commands) {
      addSubcommand(command);
    }
  }
}

abstract class Subcommand extends Command {
  final List<Option> options;

  Subcommand(this.options);

  void addOptions() {
    for (final option in options) {
      argParser.addOption(
        option.name,
        abbr: option.abbr,
        help: option.help,
        valueHelp: option.valueHelp,
        allowed: option.allowed,
        allowedHelp: option.allowedHelp,
        defaultsTo: option.defaultsTo,
        callback: option.callback,
        mandatory: option.mandatory,
        hide: option.hide,
        aliases: option.aliases,
      );
    }
  }

  String requireOption(Option option) {
    final value = argResults[option.name];
    if (value == null) throw ArgumentError();
    return value;
  }

  @override
  ArgResults get argResults =>
      super.argResults ??
      usageException('argResults cannot be used before Command.run is called.');
}

extension ArgResultsExt on ArgResults {
  T requireParam<T>(String name) {
    final p = optionalParam<T>(name);
    if (p == null) throw ArgumentError();
    return p;
  }

  T? optionalParam<T>(String name) =>
      this[name] is T ? (this[name] as T) : null;
}
