// // import 'package:freezed_annotation/freezed_annotation.dart';
// //
// // @freezed
// // class UserEntity with _$UserEntity {
// //   factory UserEntity({
// //     required int id,
// //     @JsonKey(name: "chat_id") required String chat_id
// //     @JsonKey(name: "user_id") required String user_id,
// //     required UserEntity user,
// //   }) = _UserEntity;
// //
// //   factory UserEntity.fromJson(Map<String, dynamic> json) =>
// //       _$UserEntityFromJson(json);
// // }
//
// class UserEntity {
//   String id;
//   String chatId;
//   String userId;
//   String user;
//   UserEntity({
//     required this.id,
//     required this.email,
//     required this.username});
//
//   factory UserEntity.fromJson(Map<String, dynamic> json) {
//     return UserEntity(
//       id: json['id'].toString(),
//       email: json['email'].toString(),
//       username: json['username'].toString(),
//     );
//   }
// }
//
// class AuthUser {
//   String user;
//   String token;
//   AuthUser({
//     required this.user,
//     required this.token});
//
//   factory AuthUser.fromJson(Map<String, dynamic> json) {
//     return AuthUser(
//       user: json['user'].toString(),
//       token: json['token'].toString(),
//     );
//   }
// }
