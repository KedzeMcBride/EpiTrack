class HealthStory {
  final String id;
  final String title;
  final String description;
  final String image;
  final String date;
  final String? imageUrl; // Add this for network images

  HealthStory({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    this.imageUrl,
  });

  // Copy with method for updates
  HealthStory copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? date,
    String? imageUrl,
  }) {
    return HealthStory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}