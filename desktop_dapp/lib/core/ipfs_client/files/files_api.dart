import 'package:ecert/core/ipfs_client/ipfs_client.dart';
import 'package:ecert/core/ipfs_client/models/cid.dart';
import 'package:ecert/core/ipfs_client/models/unix_fs_entry.dart';

class FilesApi {
  late IpfsClient _client;

  FilesApi(IpfsClient client) {
    _client = client;
  }

  Future<List<UnixFSEntry>> ls(String path) async {
    var data = await _client.httpPost(CID.isCID(path) ? 'ls/$path' : path);
    if (data is String) throw Exception(data);
    var res = <UnixFSEntry>[];
    if (data != null && data['Objects'] != null) {
      var links = (data['Objects'] as List)[0]["Links"] as List;

      for (var element in links) {
        final unixFSEntry = UnixFSEntry.fromJson(element);
        if (unixFSEntry != null) {
          res.add(unixFSEntry);
        }
      }
    }

    return res;
  }
}
