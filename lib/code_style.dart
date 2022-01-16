class CodeStyle {
  const CodeStyle(this.categories);

  final List<Category> categories;
}

class Category {
  const Category(this.groups);

  final List<Group> groups;
}

class Group {
  const Group(this.cases);

  final List<Case> cases;
}

class Case {
  const Case(this.description, this.examples);

  final String description;
  final List<Example> examples;
}

class Example {
  const Example(this.goodAnswer, this.badAnswer);

  final String goodAnswer;
  final String badAnswer;
}
