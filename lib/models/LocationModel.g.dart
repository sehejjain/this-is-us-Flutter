// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolLoc _$VolLocFromJson(Map<String, dynamic> json) {
  return VolLoc(
    creator: json['creator'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    contactEmail: json['contactEmail'] as String,
    location: VolLoc._fromJsonGeoPoint(json['location'] as GeoPoint),
    contactPhone: json['contactPhone'] as String,
    dateStart: VolLoc._dateTimeFromTimestamp(json['dateStart'] as Timestamp),
    dateEnd: VolLoc._dateTimeFromTimestamp(json['dateEnd'] as Timestamp),
    dateCreated:
        VolLoc._dateTimeFromTimestamp(json['dateCreated'] as Timestamp),
    desc: json['desc'] as String,
    locString: json['locString'] as String,
  );
}

Map<String, dynamic> _$VolLocToJson(VolLoc instance) => <String, dynamic>{
      'creator': instance.creator,
      'name': instance.name,
      'id': instance.id,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'locString': instance.locString,
      'dateStart': VolLoc._dateTimeAsIs(instance.dateStart),
      'dateEnd': VolLoc._dateTimeAsIs(instance.dateEnd),
      'dateCreated': VolLoc._dateTimeAsIs(instance.dateCreated),
      'desc': instance.desc,
      'location': VolLoc._toJsonGeoPoint(instance.location),
    };
