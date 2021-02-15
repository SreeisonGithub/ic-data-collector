// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

MunicipalityData productsFromJson(String str) => MunicipalityData.fromJson(json.decode(str));

String productsToJson(MunicipalityData data) => json.encode(data.toJson());

class MunicipalityData {
    MunicipalityData({
        this.total,
        this.limit,
        this.skip,
        this.data,
    });

    int total;
    int limit;
    int skip;
    List<CityValues> data;

    factory MunicipalityData.fromJson(Map<String, dynamic> json) => MunicipalityData(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<CityValues>.from(json["data"].map((x) => CityValues.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class CityValues {
    CityValues({
        this.id,
        this.name,
        this.provinceId,
        this.createdBy,
        this.updatedBy,
        this.ip,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.value,
        this.provinceValue,
    });

    String id;
    String name;
    String provinceId;
    String createdBy;
    String updatedBy;
    String ip;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String value;
    String provinceValue;

    factory CityValues.fromJson(Map<String, dynamic> json) => CityValues(
        id: json["_id"],
        name: json["name"],
        provinceId: json["province_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        ip: json["ip"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        value: json["value"],
        provinceValue: json["province_value"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "province_id": provinceId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ip": ip,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "value": value,
        "province_value": provinceValue,
    };
}
