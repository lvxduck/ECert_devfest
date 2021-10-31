library ipfs_http_client_dart;

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

import 'files/files_api.dart';
import 'models/cid.dart';
import 'models/unix_fs_entry.dart';

class IpfsClient {
  final JsonDecoder _decoder = const JsonDecoder();
  final JsonEncoder _encoder = const JsonEncoder();
  final Map<String, String> _headers = {"Content-Type": "application/json"};
  late Uri _baseUri;

  IpfsClient(String address) {
    _baseUri = Uri.parse(address);
  }

  FilesApi? _files;
  FilesApi? get files {
    _files ??= FilesApi(this);
    return _files;
  }

  Future<String> version() async {
    var res = await httpPost('version');
    return res['Version'];
  }

  Future<String> id() async {
    var res = await httpPost('id');
    return res['ID'];
  }

  Future<UnixFSEntry?> add(UnixFSEntry file) async {
    var data = await httpPostMultiPart('add', [file]);
    return UnixFSEntry.fromJson(data);
  }

  Stream<UnixFSEntry> get(String path) async* {
    var data = await httpGetBytes(CID.isCID(path) ? 'get/$path' : path);
    var archive = TarDecoder().decodeBytes(data);
    for (var file in archive) {
      var res = UnixFSEntry();
      res.path = file.name;
      res.size = file.size;
      res.content = file.content;
      res.mode = file.mode;
      res.mtime = file.lastModTime;
      yield res;
    }
  }

  Future<dynamic> httpGet(String url) {
    return _httpGet(url).then((http.Response response) {
      String res = response.body;
      if (res.isEmpty) return null;
      if (res.startsWith("{") || res.startsWith("[")) {
        return _decoder.convert(res);
      } else {
        return res;
      }
    });
  }

  Future<Uint8List> httpGetBytes(String url) {
    return _httpGet(url).then((http.Response response) {
      return response.bodyBytes;
    });
  }

  Future<http.Response> _httpGet(String url) {
    url = _getUrl(url);

    var headers = _headers;

    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("$statusCode: Error while fetching data; ${response.reasonPhrase}");
      }

      return response;
    });
  }

  Future<dynamic> httpPost(String url, {body, Encoding? encoding}) {
    url = _getUrl(url);

    var headers = _headers;

    return http
        .post(Uri.parse(url), body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("$statusCode: Error while fetching data; ${response.reasonPhrase}");
      }

      if (res.isEmpty) return null;
      if (res.startsWith("{") || res.startsWith("[")) {
        return _decoder.convert(res);
      } else {
        return res;
      }
    });
  }

  Future<dynamic> httpPostMultiPart(String url, List<UnixFSEntry> body) {
    url = _getUrl(url);

    var headers = _headers;
    if (body.isEmpty) throw Exception('body cannot be empty');

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    for (var element in body) {
      if (element.content is String) {
        request.files.add(http.MultipartFile.fromString('file', element.content as String));
      } else if (element.content is Uint8List) {
        request.files.add(http.MultipartFile.fromBytes('file', element.content as Uint8List,
            filename: element.name, contentType: element.contentType));
      } else {
        throw Exception('File content is not supported');
      }
    }

    return request.send().then((http.StreamedResponse response) async {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("$statusCode: Error while fetching data; ${response.reasonPhrase}");
      }

      final String res = await response.stream.bytesToString();

      if (res.isEmpty) return null;
      if (res.startsWith("{") || res.startsWith("[")) {
        return _decoder.convert(res);
      } else {
        return res;
      }
    });
  }

  String _getUrl(String relativeUrl) {
    if (relativeUrl.startsWith("http")) return relativeUrl;
    String url = _baseUri.toString();
    if (!url.endsWith("/")) url += "/";

    if (relativeUrl.startsWith("/")) relativeUrl = relativeUrl.substring(1);

    return url + relativeUrl;
  }
}
