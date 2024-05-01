import 'package:ss_blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.posterId,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.updateAt,
      super.posterName});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "poster_id": posterId,
      "title": title,
      "content": content,
      "image_url": imageUrl,
      "topics": topics,
      "update_at": updateAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json["id"],
      posterId: json["poster_id"],
      title: json["title"],
      content: json["content"],
      imageUrl: json["image_url"],
      topics: List<String>.from(json['topics'] ?? []),
      updateAt: json['update_at'] == null
          ? DateTime.now()
          : DateTime.parse(json["update_at"]),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updateAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updateAt: updateAt ?? this.updateAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
