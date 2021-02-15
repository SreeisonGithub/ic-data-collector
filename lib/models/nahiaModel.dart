
import 'dart:convert';

Nahia productsFromJson(String str) => Nahia.fromJson(json.decode(str));

String productsToJson(Nahia data) => json.encode(data.toJson());

class Nahia {
    Nahia({
        this.total,
        this.limit,
        this.skip,
        this.data,
    });

    int total;
    int limit;
    int skip;
    List<Areas> data;

    factory Nahia.fromJson(Map<String, dynamic> json) => Nahia(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<Areas>.from(json["data"].map((x) => Areas.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Areas {
    Areas({
        this.id,
        this.name,
        this.provinceId,
        this.municipalityId,
        this.createdBy,
        this.updatedBy,
        this.ip,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.municipalityValue,
        this.value,
    });

    String id;
    String name;
    Id provinceId;
    Id municipalityId;
    String createdBy;
    String updatedBy;
    String ip;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String municipalityValue;
    String value;

    factory Areas.fromJson(Map<String, dynamic> json) => Areas(
        id: json["_id"],
        name: json["name"],
        provinceId: idValues.map[json["province_id"]],
        municipalityId: idValues.map[json["municipality_id"]],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ip: json["ip"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        municipalityValue: json["municipality_value"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "province_id": idValues.reverse[provinceId],
        "municipality_id": idValues.reverse[municipalityId],
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip": ip,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "municipality_value": municipalityValue,
        "value": value == null ? null : value,
    };
}

enum Id { KABUL, ID_KABUL }

final idValues = EnumValues({
    "Kabul": Id.ID_KABUL,
    "kabul": Id.KABUL
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
