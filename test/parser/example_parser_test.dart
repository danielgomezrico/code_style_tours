import 'package:code_style_tours/code_style.dart';
import 'package:code_style_tours/parser/example_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ExampleParser subject() => ExampleParser();

  group('.parse', () {
    group('with multiple examples', () {
      final markdown = '''
      ```language-name
        // Avoid
        Bad Example 1
        
        // Prefer
        Good Example 1
        
        // Avoid
        Bad Example 2
        
        // Prefer
        Good Example 2
      ```
      ''';
      late List<Example> examples;

      setUpAll(() {
        examples = subject().parse(markdown);
      });

      test('returns all of the examples', () {
        expect(examples, hasLength(2));
      });

      test('returns the first example with all answers', () {
        expect(
          examples[0],
          isA<Example>()
              .having((e) => e.goodAnswer, 'good', 'Good Example 1')
              .having((e) => e.badAnswer, 'bad', 'Bad Example 1'),
        );
      });

      test('returns the second example with all answers', () {
        expect(
          examples[1],
          isA<Example>()
              .having((e) => e.goodAnswer, 'good', 'Good Example 2')
              .having((e) => e.badAnswer, 'bad', 'Bad Example 2'),
        );
      });
    });

    group('just examples with empty spaces', () {
      final markdown = '''
      ```language-name
        // Avoid
        Bad Example 1            
        
        // Prefer
        Good Example 1
        
      ```
      ''';
      late List<Example> examples;

      setUpAll(() {
        try {
          examples = subject().parse(markdown);
        }catch(e) {
          print(e);
        }
      });

      test('the example contains all answers sanitized', () {
        expect(examples, hasLength(1));

        expect(
          examples[0],
          isA<Example>()
              .having((e) => e.goodAnswer, 'good', 'Good Example 1')
              .having((e) => e.badAnswer, 'bad', 'Bad Example 1'),
        );
      });
    });
  });
}
