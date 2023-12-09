import 'dart:convert';

import '../../../../core/utilities/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.avatar,
      required super.createdAt,
      required super.name});

  const UserModel.empty()
      : this(
            id: '1',
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar');

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel copyWith({
    String? avatar,
    String? name,
    String? id,
    String? createdAt,
  }) {
    return UserModel(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name);
  }

  UserModel.fromMap(DataMap map)
      : this(
          createdAt: map['createdAt'] as String,
          name: map['name'] as String,
          avatar: map['avatar'] as String,
          id: map['id'] as String,
        );

  DataMap toMap() =>
      {"createdAt": createdAt, "name": name, "avatar": avatar, "id": id};

  String toJson() => jsonEncode(toMap());
}
