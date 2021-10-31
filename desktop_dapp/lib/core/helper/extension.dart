import 'dart:io';

extension FileExtension on FileSystemEntity {
  String? get name {
    return path.split("/").last;
  }
}

extension StringExtension on String {
  String get ipfs {
    return "https://ipfs.io/ipfs/$this";
  }

  String toCapitalized() => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.toCapitalized()).join(" ");
}
