// File: topics_model.dart
class TopicsModel {
  String? topicId;
  String name;
  String description;
  String creationDate;
  String lastAccessed;
  String creatorId;
  bool public;
  String? folderId;

  TopicsModel({
    this.topicId,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.lastAccessed,
    required this.creatorId,
    required this.public,
    this.folderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'creationDate': creationDate,
      'lastAccessed': lastAccessed,
      'creatorId': creatorId,
      'public': public,
      'folderId': folderId,
    };
  }

  factory TopicsModel.fromSnapshot(Map<String, dynamic> snapshot, String id) {
    return TopicsModel(
      topicId: id,
      name: snapshot['name'] ?? '',
      description: snapshot['description'] ?? '',
      creationDate: snapshot['creationDate'] ?? '',
      lastAccessed: snapshot['lastAccessed'] ?? '',
      creatorId: snapshot['creatorId'] ?? '',
      public: snapshot['public'] ?? false,
      folderId: snapshot['folderId'] ?? ''
    );
  }
}
