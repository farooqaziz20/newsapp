import 'package:json_annotation/json_annotation.dart';

import 'article.dart';
import 'base_response.dart';


part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse extends BaseResponse {
  List<Article>? articles;

  ArticleResponse({
    this.articles,
    required bool status,
  }) : super(status: status);

  @override
  List<Object?> get props => [
        ...super.props,
        articles,
      ];

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}
