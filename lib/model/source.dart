class SourceModel{
  final String apiKey;
  final String language;
  final String country;
  final String name;
  final String id;
  final String category;


  SourceModel(this.apiKey, this.language, this.country, this.name, this.id,
      this.category);

  SourceModel.fromJson(Map<String,dynamic>json):
        name=json["name"],
        apiKey=json["apiKey"],
        language=json["language"],
        country=json["country"],
        id=json["id"],
        category=json["category"];

}