class Certificate {
  String cid;
  String timeAdd;
  String name;
  String type;
  String eye = "eye";
  Map<String, dynamic> extraData;

  Certificate(
      {required this.cid, required this.timeAdd, required this.name, required this.type, required this.extraData});

  factory Certificate.fromJson({required Map<String, dynamic> json, required String cid}) {
    return Certificate(
      cid: cid,
      timeAdd: json['time_add'],
      name: json["họ tên"],
      type: json["type_cert"],
      extraData: json,
    );
  }

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'timeAdd': timeAdd,
        'name': name,
        'type': type,
      };
}
