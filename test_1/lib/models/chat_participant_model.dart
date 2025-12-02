// import 'package:freezed_annotation/freezed_annotation.dart';
//
// @freezed
// class ChatParticipantEntity with _$ChatParticipantEntity {
//   factory ChatParticipantEntity({
//     required int id,
//     required String email,
//     required String username,
//     @JsonKey(name: "created_at") required String createdAt,
//     required String color,
//   }) = _ChatParticipantEntity;
//
//   factory ChatParticipantEntity.fromJson(Map<String, dynamic> json) =>
//       _$ChatParticipantEntityFromJson(json);
// }


class ChatParticipantEntity {
  String id;
  String email;
  String username;
  ChatParticipantEntity({
    required this.id,
    required this.email,
    required this.username});

  factory ChatParticipantEntity.fromJson(Map<String, dynamic> json) {
    return ChatParticipantEntity(
      id: json['id'].toString(),
      email: json['email'].toString(),
      username: json['username'].toString(),
    );
  }
}