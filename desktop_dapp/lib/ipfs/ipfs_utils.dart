import 'dart:convert';
import 'dart:io';

import 'package:ecert/core/helper/extension.dart';
import 'package:ecert/ipfs/ipfs_client/ipfs_client.dart';
import 'package:ecert/ipfs/ipfs_client/models/unix_fs_entry.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class IpfsUtils {
  static final _singleton = IpfsUtils._init();
  final IpfsClient _ipfsClient = IpfsClient('https://ipfs.infura.io:5001/api/v0');

  factory IpfsUtils() {
    return _singleton;
  }

  IpfsUtils._init();

  Future<UnixFSEntry?> uploadImage(File imageFile) async {
    var file = UnixFSEntry();
    file.content = await imageFile.readAsBytes();
    file.name = imageFile.name ?? "avata.png";
    file.contentType = MediaType.parse("image/png");
    final res = await _ipfsClient.add(file);
    return res;
  }

  Future<UnixFSEntry?> uploadJsonData({
    required String content,
    String name = "ecert_certificate",
  }) async {
    var file = UnixFSEntry();
    file.content = content;
    file.name = name;
    file.contentType = MediaType.parse("text/plain");
    final res = await _ipfsClient.add(file);
    return res;
  }

  Future<String> getData(String cid) async {
    // final res = await _ipfsClient.get("https://ipfs.io/ipfs/${cid}").first;
    final http.Response res = await http.get(Uri.parse("https://ipfs.io/ipfs/${cid}"));
    String body = utf8.decode(res.bodyBytes);
    return body;
  }
}
