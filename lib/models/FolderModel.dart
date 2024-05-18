class FolderModel {
  final String name;
  final String description;

  FolderModel({required this.name, required this.description});

  Map<String, dynamic> toJson() {
   return {
     'name': name,
     'description': description,
   };
  }


}