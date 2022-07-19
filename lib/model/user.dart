class User {
  final String? id;
  final String? email;
  final String? imageUrl;

  final String? accessToken;
  final String? client;
  final String? tokenType;
  final String? uid;

  const User({
    this.id,
    this.email,
    this.imageUrl,
    this.accessToken,
    this.client,
    this.tokenType,
    this.uid,
  });

  User copyWith({
    String? id,
    String? email,
    String? imageUrl,
    String? accessToken,
    String? client,
    String? tokenType,
    String? uid,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        accessToken: accessToken ?? this.accessToken,
        client: client ?? this.client,
        tokenType: tokenType ?? this.tokenType,
        uid: uid ?? this.uid,
      );

  @override
  User.fromJson(Map<String, dynamic> json)
      : id = json[UserJsonKeys.id],
        email = json[UserJsonKeys.email],
        imageUrl = json[UserJsonKeys.imageUrl],
        accessToken = json[UserJsonKeys.accessToken],
        client = json[UserJsonKeys.client],
        tokenType = json[UserJsonKeys.tokenType],
        uid = json[UserJsonKeys.uid];
}

abstract class UserJsonKeys {
  static const String id = 'id';
  static const String email = 'email';
  static const String imageUrl = 'image_url';

  static const String accessToken = 'access-token';
  static const String client = 'client';
  static const String tokenType = 'token-type';
  static const String uid = 'uid';
}
