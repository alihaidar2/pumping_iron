// import 'package:objectbox/objectbox.dart';

// @Entity()
class Exercise {
  int? id;
  final String? name;
  final String? target;
  final String? bodyPart;
  final String? equipment;
  final String? gifUrl;

  Exercise({
    this.id = 0,
    required this.name,
    required this.target,
    required this.bodyPart,
    required this.equipment,
    required this.gifUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        id: int.tryParse(json['id'].toString()),
        name: json["name"].toString(),
        target: json["target"].toString(),
        bodyPart: json["bodyPart"].toString(),
        equipment: json["equipment"].toString(),
        gifUrl: json["gifUrl"].toString());
  }
}
