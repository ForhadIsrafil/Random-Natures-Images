import 'package:requests/requests.dart';
import 'dart:async';
import 'dart:convert';
import 'package:random_nature/models/imageDataModel.dart';

Future<ImageLink> getImageData() async {
  var res = await Requests.get(
      "https://api.unsplash.com/photos/random?client_id=FwiGhresQ8iK6t7IIEIGI-rNeJ9qw4Xn7ow4Bd4CXVQ&count=1&query=nature");
  if (res.statusCode == 200) {
    // print(res.json()[0]);
    var description = res.json()[0]["description"];
    var alt_description = res.json()[0]["alt_description"];
    var regular_image_url = res.json()[0]["urls"]['regular'];
    var small_image_url = res.json()[0]["urls"]['small'];
    // print(description);
    // print(alt_description);
    // print(regular_image_url);
    return ImageLink.fromMap({
      "description": description,
      "alt_description": alt_description,
      "regular_image_url": regular_image_url,
      "small_image_url": small_image_url,
    });
  } else {
    return ImageLink.fromMap({
      "description": Null,
      "alt_description": Null,
      "regular_image_url": Null,
      "small_image_url": Null,
    });
  }
}

