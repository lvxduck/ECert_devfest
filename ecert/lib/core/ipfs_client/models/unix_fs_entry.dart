import 'package:http_parser/http_parser.dart';

class UnixFSEntry {
  late String name;
  late String path;
  late String cid;
  late int size;
  late int type;
  late String target;
  dynamic content;
  late int mode;
  late int mtime;
  late MediaType contentType;

  static UnixFSEntry? fromJson(x) {
    if (x == null) return null;
    var res = UnixFSEntry();
    res.name = x['Name'];
    res.path = x['Path'];
    res.cid = x['Hash'];
    if (x['Size'] is int) {
      res.size = x['Size'] as int;
    } else {
      res.size = int.parse(x['Size']);
    }
    res.type = x['Type'];
    res.target = x['Target'];
    res.content = x['Content'];
    res.mode = x['Mode'];
    res.mtime = x['Mtime'];
    if (x['ContentType'] != null && x['ContentType'] is String) res.contentType = MediaType.parse(x['ContentType']);

    return res;
  }
}
