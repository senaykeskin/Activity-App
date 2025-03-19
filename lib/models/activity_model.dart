class EventItem {
  final int? id;
  final String? name;
  final String? slug;
  final String? url;
  final String? content;
  final DateTime? start;
  final DateTime? end;
  final bool? isFree;
  final String? posterUrl;
  final String? ticketUrl;
  final EventFormat? format;
  final EventCategory? category;
  final Venue? venue;
  final List<Tag>? tags;

  EventItem({
    this.id,
    this.name,
    this.slug,
    this.url,
    this.content,
    this.start,
    this.end,
    this.isFree,
    this.posterUrl,
    this.ticketUrl,
    this.format,
    this.category,
    this.venue,
    this.tags,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      url: json['url']?.toString(),
      content: json['content']?.toString(),
      start: json['start'] != null ? DateTime.tryParse(json['start']) : null,
      end: json['end'] != null ? DateTime.tryParse(json['end']) : null,
      isFree: json['is_free'],
      posterUrl: json['poster_url']?.toString(),
      ticketUrl: json['ticket_url']?.toString(),
      format:
          json['format'] != null ? EventFormat.fromJson(json['format']) : null,
      category: json['category'] != null
          ? EventCategory.fromJson(json['category'])
          : null,
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
      tags: json['tags'] != null
          ? (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList()
          : null,
    );
  }
}

class EventFormat {
  final int? id;
  final String? name;
  final String? slug;

  EventFormat({this.id, this.name, this.slug});

  factory EventFormat.fromJson(Map<String, dynamic> json) {
    return EventFormat(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
    );
  }
}

class EventCategory {
  final int? id;
  final String? name;
  final String? slug;

  EventCategory({this.id, this.name, this.slug});

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
    );
  }
}

class Venue {
  final int? id;
  final String? name;
  final String? slug;
  final String? about;
  final double? lat;
  final double? lng;
  final String? address;
  final District? district;
  final City? city;

  Venue({
    this.id,
    this.name,
    this.slug,
    this.about,
    this.lat,
    this.lng,
    this.address,
    this.district,
    this.city,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      about: json['about']?.toString(),
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : null,
      lng: json['lng'] != null ? double.tryParse(json['lng'].toString()) : null,
      address: json['address']?.toString(),
      district:
          json['district'] != null ? District.fromJson(json['district']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }
}

class City {
  final int? id;
  final String? name;
  final String? slug;

  City({this.id, this.name, this.slug});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
    );
  }
}

class District {
  final String? name;

  District({this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      name: json['name']?.toString(),
    );
  }
}

class Tag {
  final int? id;
  final String? name;
  final String? slug;

  Tag({this.id, this.name, this.slug});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
    );
  }
}
