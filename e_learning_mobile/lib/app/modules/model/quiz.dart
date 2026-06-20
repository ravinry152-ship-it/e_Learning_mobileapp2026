class Quiz {
  int? id;
  String? questionText;
  int? order;
  List<Choices>? choices;

  Quiz({this.id, this.questionText, this.order, this.choices});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['question_text'];
    order = json['order'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_text'] = this.questionText;
    data['order'] = this.order;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  int? id;
  int? question;
  String? prefix;
  String? choiceText;

  Choices({this.id, this.question, this.prefix, this.choiceText});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    prefix = json['prefix'];
    choiceText = json['choice_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['prefix'] = this.prefix;
    data['choice_text'] = this.choiceText;
    return data;
  }
}
