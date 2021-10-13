import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
import 'source.dart';


part 'source_response.g.dart';

@JsonSerializable()
class SourceResponse extends BaseResponse {
  List<Source>? sources;

  SourceResponse({
    this.sources,
    required bool status,
  }) : super(status: status);

  @override
  List<Object?> get props => [
        ...super.props,
        sources,
      ];

  factory SourceResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);
}
