import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class EcertSmartContract {
  static final EcertSmartContract _singleton = EcertSmartContract._init();

  factory EcertSmartContract() {
    return _singleton;
  }

  final String _rpcUrl = "http://192.168.226.1:7545";
  final String _wsUrl = "ws://192.168.226.1:7545/";

  late String _privateKey;
  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late DeployedContract _contract;

  late ContractFunction _generateCertificate;
  late ContractFunction _getCertificate;

  EcertSmartContract._init() {
    initiateSetup();
  }

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _privateKey = prefs.getString("privateKey");
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Certificates.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    // print(_contractAddress);
    // print(_abiCode);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Certificates"), _contractAddress);
    _generateCertificate = _contract.function("generateCertificate");
    _getCertificate = _contract.function("getCertificate");
  }

  Future<String> addCertificate(String ipfsHash) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolId = prefs.getString("schoolId");
    final res = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(contract: _contract, function: _generateCertificate, parameters: [ipfsHash, schoolId]),
    );
    return res;
  }

  Future getCertificate(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final schoolId = prefs.getString("schoolId");
    return await _client.call(contract: _contract, function: _getCertificate, params: [schoolId, id]).catchError((e) {
      print(e);
    });
  }
}
