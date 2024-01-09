import '../../domain/entities/ads.dart';

class AdsModel extends Ads {
  const AdsModel({
    required super.link,
    required super.image,
  });

  factory AdsModel.fromMap(Map<String, dynamic> map) => AdsModel(
        link: map['link'],
        image: map['image'],
      );

  Map<String, dynamic> toMap() => {
        'link': link,
        'image': image,
      };
}
