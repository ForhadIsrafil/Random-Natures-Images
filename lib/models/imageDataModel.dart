

class ImageLink {
  final String description;
  final String alt_description;
  final String regular_image_url;
  final String small_image_url;

  ImageLink({
    required this.description,
    required this.alt_description,
    required this.regular_image_url,
    required this.small_image_url,
  });

  factory ImageLink.fromMap(data) {
    return ImageLink(
      description: data['description'],
      alt_description: data['alt_description'],
      regular_image_url: data['regular_image_url'],
      small_image_url: data['small_image_url'],
    );
  }
}
