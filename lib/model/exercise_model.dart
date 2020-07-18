class ExerciseModel {
  String answer;
  String choiceA;
  String choiceB;
  String choiceC;
  String question;

  ExerciseModel(
      {this.answer, this.choiceA, this.choiceB, this.choiceC, this.question});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    answer = json['Answer'];
    choiceA = json['ChoiceA'];
    choiceB = json['ChoiceB'];
    choiceC = json['ChoiceC'];
    question = json['Question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answer'] = this.answer;
    data['ChoiceA'] = this.choiceA;
    data['ChoiceB'] = this.choiceB;
    data['ChoiceC'] = this.choiceC;
    data['Question'] = this.question;
    return data;
  }
}

