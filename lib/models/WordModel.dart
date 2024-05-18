// File: word_model.dart
class WordModel {
  String? wordId;
  String description;
  String english;
  String illustration;
  String pronunciation;
  String vietnamese;

  WordModel({
    this.wordId,
    required this.description,
    required this.english,
    required this.illustration,
    required this.pronunciation,
    required this.vietnamese,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'english': english,
      'illustration': illustration,
      'pronunciation': pronunciation,
      'vietnamese': vietnamese,
    };
  }

  factory WordModel.fromSnapshot(Map<String, dynamic> snapshot, String id) {
    return WordModel(
      wordId: id,
      description: snapshot['description'] ?? '',
      english: snapshot['english'] ?? '',
      illustration: snapshot['illustration'] ?? '',
      pronunciation: snapshot['pronunciation'] ?? '',
      vietnamese: snapshot['vietnamese'] ?? '',
    );
  }
}
