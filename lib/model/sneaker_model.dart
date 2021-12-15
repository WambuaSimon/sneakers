class Sneaker {
  final String id;
  final String brand;
  final String colorway;
  final String gender;
  final int year;
  final int retailPrice;
  final String shoe;
  final String title;
  final Media media;

  Sneaker(this.id, this.brand, this.colorway, this.gender, this.year,
      this.retailPrice, this.shoe, this.title, this.media);

  Sneaker.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brand = json['brand'],
        colorway = json['colorway'],
        gender = json['gender'],
        year = json['year'],
        retailPrice = json['retailPrice'],
        shoe = json['shoe'],
        title = json['title'],
        media = Media.fromJson(json['media']);
}

class Media {
  final String? imageUrl;

  Media(this.imageUrl);

  Media.fromJson(Map<String, dynamic> json) : imageUrl = json['imageUrl'];
}

class SneakerResponse {
  final List<Sneaker> results;
  final int count;
  final String error;

  SneakerResponse(this.results, this.count, this.error);

  SneakerResponse.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        results =
            (json['results'] as List).map((e) => Sneaker.fromJson(e)).toList(),
        error = "";

  SneakerResponse.withError(String errorValue):
      count = 0,
      results = [],
  error = errorValue;
}
