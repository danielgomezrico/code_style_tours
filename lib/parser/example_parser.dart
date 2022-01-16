import 'package:code_style_tours/code_style.dart';

class ExampleParser {
  List<Example> parse(String markdown) {
    final examples = <Example>[];

    final eachLine = markdown.split('\n');

    String? badAnswer;
    String? goodAnswer;
    var isBadAnswer = true;
    List<String> answerEntries = [];

    void process() {
      if (answerEntries.isNotEmpty) {
        final answer = answerEntries.join("\n").trim();

        if (isBadAnswer) {
          badAnswer = answer;
        } else {
          goodAnswer = answer;
        }

        if (goodAnswer != null && badAnswer != null) {
          final example = Example(goodAnswer!, badAnswer!);
          examples.add(example);

          goodAnswer = null;
          badAnswer = null;
        }

        answerEntries = [];
      }
    }

    eachLine.asMap().forEach((index, line) {
      if (line.contains('//')) {
        process();
        isBadAnswer = line.toLowerCase().trim().startsWith('// avoid');
      } else if (!line.contains('```')) {
        answerEntries.add(line);
      }

      if (index == eachLine.length - 1){
        process();
      }
    });

    return examples;
  }
}
