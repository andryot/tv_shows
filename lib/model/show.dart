class Show {
  final String id;
  final int averageRating;
  final String description;
  final int numberOfReviews;
  final String title;
  final String imageUrl;

  const Show({
    required this.id,
    required this.averageRating,
    required this.description,
    required this.numberOfReviews,
    required this.title,
    required this.imageUrl,
  });

  Show.fromJson(Map<String, dynamic> json)
      : id = json[ShowJsonKeys.id],
        averageRating = json[ShowJsonKeys.averageRating],
        description = json[ShowJsonKeys.description],
        numberOfReviews = json[ShowJsonKeys.numberOfReviews],
        title = json[ShowJsonKeys.title],
        imageUrl = json[ShowJsonKeys.imageUrl];
}

abstract class ShowJsonKeys {
  static const String id = 'id';
  static const String averageRating = 'average_rating';
  static const String description = 'description';
  static const String numberOfReviews = 'no_of_reviews';
  static const String title = 'title';
  static const String imageUrl = 'image_url';
}
