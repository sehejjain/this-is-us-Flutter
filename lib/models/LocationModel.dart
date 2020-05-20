import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LocationModel.g.dart';

@JsonSerializable()
class VolLoc {
  String creator;
  String name;
  String id;
  String contactEmail;
  String contactPhone;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  DateTime dateStart;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  DateTime dateEnd;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  DateTime dateCreated;
  String desc;
  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  GeoPoint location;

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static DateTime _dateTimeAsIs(DateTime dateTime) =>
      dateTime; //<-- pass through no need for generated code to perform any formatting

// https://stackoverflow.com/questions/56627888/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter
  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) {
    return DateTime.parse(timestamp.toDate().toString());
  }

  VolLoc({
    this.creator,
    this.id,
    this.name,
    this.contactEmail,
    this.location,
    this.contactPhone,
    this.dateStart,
    this.dateEnd,
    this.dateCreated,
    this.desc,
  });

  factory VolLoc.fromJson(Map<String, dynamic> json) => _$VolLocFromJson(json);

  Map<String, dynamic> toJson() => _$VolLocToJson(this);
}
