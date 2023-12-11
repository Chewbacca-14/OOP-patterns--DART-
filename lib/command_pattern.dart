// Шаг 1: Создаем интерфейс команды
abstract class Command {
  void execute();
  void undo();
}

// Шаг 2: Создаем конкретные классы команд, реализующие интерфейс
class TextEditor {
  String _text = '';

  void addText(String text) {
    _text += text;
    print('Добавлен текст: $text');
  }

  void deleteLastWord() {
    if (_text.isNotEmpty) {
      final lastSpaceIndex = _text.lastIndexOf(' ');
      _text = _text.substring(0, lastSpaceIndex);
      print('Удалено последнее слово');
    } else {
      print('Нет текста для удаления');
    }
  }

  String getText() => _text;
}

class AddTextCommand implements Command {
  final TextEditor textEditor;
  final String textToAdd;

  AddTextCommand(this.textEditor, this.textToAdd);

  @override
  void execute() {
    textEditor.addText(textToAdd);
  }

  @override
  void undo() {
    final lengthToRemove = textToAdd.length;
    textEditor.deleteLastWord();
    print(
        'Отменено добавление текста: ${textToAdd.substring(0, lengthToRemove)}');
  }
}

class DeleteLastWordCommand implements Command {
  final TextEditor textEditor;

  DeleteLastWordCommand(this.textEditor);

  @override
  void execute() {
    textEditor.deleteLastWord();
  }

  @override
  void undo() {
    // Нельзя точно восстановить удаленное слово, поэтому не реализуем undo
    print('Невозможно отменить удаление последнего слова');
  }
}

// Шаг 3: Создаем класс инициатора команд
class TextEditorInvoker {
  final List<Command> _commandHistory = [];

  void executeCommand(Command command) {
    command.execute();
    _commandHistory.add(command);
  }

  void undoLastCommand() {
    if (_commandHistory.isNotEmpty) {
      final lastCommand = _commandHistory.removeLast();
      lastCommand.undo();
    } else {
      print('Нет команд для отмены');
    }
  }
}

// Шаг 4: Используем паттерн команды
void commandPattern() {
  final textEditor = TextEditor();
  final invoker = TextEditorInvoker();

  // Добавляем текст
  final addTextCommand1 = AddTextCommand(textEditor, 'Привет, ');
  invoker.executeCommand(addTextCommand1);

  // Удаляем последнее слово
  final deleteLastWordCommand = DeleteLastWordCommand(textEditor);
  invoker.executeCommand(deleteLastWordCommand);

  // Повторяем удаление последнего слова (undo отменит предыдущую команду)
  invoker.undoLastCommand();

  // Добавляем еще текст
  final addTextCommand2 = AddTextCommand(textEditor, 'мир!');
  invoker.executeCommand(addTextCommand2);

  // Выводим итоговый текст
  print('Итоговый текст: ${textEditor.getText()}');
}
