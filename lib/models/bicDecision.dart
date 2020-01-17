class BicDecision {
  String id;
  String pid;
  String uid;
  String remark;
  String createdBy;
  String updatedBy;
  String ip;
  BicDecision(
      {this.id,
      this.pid,
      this.uid,
      this.remark,
      this.createdBy,
      this.updatedBy,
      this.ip
      });

  BicDecision.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        pid = json['pid'],
        uid = json['uid'],
        remark = json['remark'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        ip = json['ip'];
  Map<String, dynamic> toJson() => {
        '_id': id,
        'pid': pid,
        'uid': uid,
        'remark': remark,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'ip': ip
      };
}