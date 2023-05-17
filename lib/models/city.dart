class City{
  final int id;
  final String name;
  final String state;
  final String country;
  final double long;
  final double lat;

  City({
    required this.id,
    required this.name,
    required this.state,
    required this.country,
    required this.long,
    required this.lat,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'].toInt(),
      name: json['name'],
      state: json['state'],
      country: json['country'],
      long: (json['coord']['lon']).toDouble(),
      lat: (json['coord']['lat']).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'state': state,
    'country': country,
    'coord': {
      'lon': long,
      'lat': lat,
    }
  };
}