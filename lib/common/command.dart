import 'package:args/args.dart';
import 'package:args/command_runner.dart';

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
    assert(value == null);
    return value;
  }

  @override
  ArgResults get argResults =>
      super.argResults ??
      usageException('argResults cannot be used before Command.run is called.');
}

abstract class Option<T> {
  final String name;
  final String? abbr;
  final String? help;
  final String? valueHelp;
  final Iterable<String>? allowed;
  final Map<String, String>? allowedHelp;
  final String? defaultsTo;
  final void Function(String?)? callback;
  final bool mandatory;
  final bool hide;
  final List<String> aliases;

  Option(
    this.name, {
    this.abbr,
    this.help,
    this.valueHelp,
    this.allowed,
    this.allowedHelp,
    this.defaultsTo,
    this.callback,
    this.mandatory = false,
    this.hide = false,
    this.aliases = const [],
  });
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
