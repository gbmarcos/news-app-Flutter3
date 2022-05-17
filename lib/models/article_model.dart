class ArticleModel {
  int? id;
  bool? featured;
  String? title;
  String? url;
  String? imageUrl;
  String? newsSite;
  String? summary;
  DateTime? publishedAt;

  ArticleModel({
    this.id,
    this.featured,
    this.title,
    this.url,
    this.imageUrl,
    this.newsSite,
    this.summary,
    this.publishedAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    featured = json["featured"];
    title = json["title"]?.toString();
    url = json["url"]?.toString();
    imageUrl = json["imageUrl"]?.toString();
    newsSite = json["newsSite"]?.toString();
    summary = json["summary"]?.toString();
    publishedAt = DateTime.tryParse(json["publishedAt"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["featured"] = featured ?? false ? 1 : 0;
    data["title"] = title;
    data["url"] = url;
    data["imageUrl"] = imageUrl;
    data["newsSite"] = newsSite;
    data["summary"] = summary;
    data["publishedAt"] = publishedAt?.toIso8601String();
    return data;
  }
}
