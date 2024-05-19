class FolderModel {
  final String name;
  final String description;
  final String creatorId;

  FolderModel({required this.name, required this.description, required this.creatorId});

  Map<String, dynamic> toJson() {
   return {
     'name': name,
     'description': description,
     'creatorId': creatorId
   };
  }
}