import 'package:ecert/core/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

class AuthApi {
  AuthApi._();

  static const issuer = "cc8dcd4809fbbe096655388eee3d7f62162b4945335ad43143403e1199094f7c";
  static const verifier = "166b9394a984177dfaf0c8d42ac052ac75a058e08371df046674f78b523c8a0b";
  static const viewer = "feeb2cfa2d8fe687dc2d2c198b4c8342419628810137b947f1a9f8aaf4f362d0";

  static Future<UserType> signIn(String privateKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final address = await EthPrivateKey.fromHex(privateKey).extractAddress();
    await prefs.setString("address", address.hex);
    await prefs.setString("privateKey", privateKey);
    print('privateKey: $privateKey');
    print('address: $address');
    // Connect to Ethereum and get userType
    Future.delayed(const Duration(milliseconds: 800));
    switch (privateKey) {
      case issuer:
        return UserType.issuer;
      case verifier:
        return UserType.verifier;
      case viewer:
        return UserType.viewer;
      default:
        return UserType.viewer;
    }
  }

  Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
