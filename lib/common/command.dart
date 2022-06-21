import 'package:args/command_runner.dart';

abstract class CommandGroup<T> extends Command<T> {
  void addSubCommands(List<Command<T>> commands) {
    for (final command in commands) {
      addSubcommand(command);
    }
  }
}
