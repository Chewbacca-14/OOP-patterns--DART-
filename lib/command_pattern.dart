// ignore_for_file: public_member_api_docs, sort_constructors_first
//command interface
import 'dart:developer';

abstract class Command {
  void execute();
  void undo();
}

//concrete commands
class LightOnCommands implements Command {
  Light light;
  LightOnCommands({
    required this.light,
  });

  @override
  void execute() {
    light.turnOn();
  }

  @override
  void undo() {
    light.turnOff();
  }
}

class TVOnCommands implements Command {
  TV tv;
  TVOnCommands({
    required this.tv,
  });

  @override
  void execute() {
    tv.turnOn();
  }

  @override
  void undo() {
    tv.turnOff();
  }
}

//Receiver class
class Light {
  void turnOn() {
    print('Light Turned On');
  }

  void turnOff() {
    print('Light Turned OFF');
  }
}

class TV {
  void turnOn() {
    print('TV On');
  }

  void turnOff() {
    print('TV OFF');
  }
}

class RemoteControl {
  List<Command> commands = [];

  void addCommand(Command command) {
    commands.add(command);
  }

  void executeCommands() {
    for (var command in commands) {
      command.execute();
    }
  }

  void undoCommand() {
    if (commands.isNotEmpty) {
      Command lastCommand = commands.removeLast();
      lastCommand.undo();
      log('Removed was: ${lastCommand.toString()}');
    } else {
      print('No commands to undo');
    }
  }

  //client
}

void commandPattern() {
  RemoteControl remoteControl = RemoteControl();
  Light light = Light();
  TV tv = TV();

  Command lightOnCommand = LightOnCommands(light: light);
  Command tvOnCommand = TVOnCommands(tv: tv);

  remoteControl.addCommand(lightOnCommand);
  remoteControl.addCommand(tvOnCommand);

  print('RUN:');
  remoteControl.executeCommands();
  print('UNDO');
  remoteControl.undoCommand();
}
