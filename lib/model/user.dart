class User {
  final String? id;
  final String? email;
  final String? imageUrl;

  final String? accessToken;
  final String? client;
  final String? tokenType;
  final String? uid;
  final int? expiry;

  User({
    this.id,
    this.email,
    this.imageUrl,
    this.accessToken,
    this.client,
    this.tokenType,
    this.uid,
    this.expiry,
  });

  User copyWith({
    String? id,
    String? email,
    String? imageUrl,
    String? accessToken,
    String? client,
    String? tokenType,
    String? uid,
    int? expiry,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        accessToken: accessToken ?? this.accessToken,
        client: client ?? this.client,
        tokenType: tokenType ?? this.tokenType,
        uid: uid ?? this.uid,
        expiry: expiry ?? this.expiry,
      );

  @override
  User.fromJson(Map<String, dynamic> json)
      : id = json[UserJsonKeys.id] as String,
        email = json[UserJsonKeys.email] as String,
        imageUrl = json[UserJsonKeys.imageUrl] as String,
        accessToken = json[UserJsonKeys.accessToken] as String,
        client = json[UserJsonKeys.client] as String,
        tokenType = json[UserJsonKeys.tokenType] as String,
        uid = json[UserJsonKeys.uid] as String,
        expiry = (json[UserJsonKeys.expiry] as int);

  Map<String, dynamic> toJson() {
    return {
      UserJsonKeys.id: id,
      UserJsonKeys.email: email,
      UserJsonKeys.imageUrl: imageUrl,
      UserJsonKeys.accessToken: accessToken,
      UserJsonKeys.client: client,
      UserJsonKeys.tokenType: tokenType,
      UserJsonKeys.uid: uid,
      UserJsonKeys.expiry: expiry,
    };
  }
}

abstract class UserJsonKeys {
  static const String id = 'id';
  static const String email = 'email';
  static const String imageUrl = 'image_url';

  static const String accessToken = 'access-token';
  static const String client = 'client';
  static const String tokenType = 'token-type';
  static const String uid = 'uid';
  static const String expiry = 'expiry';
}
