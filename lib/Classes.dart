import 'dart:convert';

class Breed {
  final String id;
  final String name;
  
  const Breed({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
    'id': id,
    'name': name
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Breed(
      id: map['id'],
      name: map['name']
    );
  }

  toJson() => json.encode(toMap());

  static fromJson(String src) => fromMap(json.decode(src));

}


class CatPhoto {
  final String id;
  final String url;
  final int width;
  final int height;

  const CatPhoto({this.id, this.url, this.width=0, this.height=0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'width': width,
      'height': height,
    };
  }

  static CatPhoto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CatPhoto(
      id: map['id'],
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }

  String toJson() => json.encode(toMap());

  static CatPhoto fromJson(String src) => fromMap(json.decode(src));

  @override
  String toString() {
    return 'CatPhoto(id: $id, url: $url, width: $width, height: $height';
  }
}

class Glitch {
  String message;

  Glitch({this.message});

  @override
  String toString() {
  return 'Glitch(message: $message)';
   }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Glitch && o.message == this.message;
  } 

  @override
  int get hashCode => message.hashCode;
}
