import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class EcertSmartContract extends ChangeNotifier {
  static final EcertSmartContract _singleton = EcertSmartContract._init();

  factory EcertSmartContract() {
    return _singleton;
  }

  final String _rpcUrl = "http://192.168.226.1:7545";
  final String _wsUrl = "ws://192.168.226.1:7545/";

  final String _privateKey = "f861a3ac794f13a96454a2097ef0fac3b37538891a1f958b50d06f3ea2658baf";
  late Web3Client _client;
  late String _abiCode;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late ContractFunction _generateCertificate;

  EcertSmartContract._init() {
    initiateSetup();
  }

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    // Wallet.createNew(credentials, password, random)

    await getAbi();
    await getCredentials();
    await getDeployedContract();
    await addCertificate("QmXJ4vdGmy1q7jA8LRHjkA3roiAWqj7rBJUus9tF3Lwrby");
  }

  Future<void> getAbi() async {
    print("getAbi");
    String abiStringFile = await rootBundle.loadString("src/abis/Certificates.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
    print(_abiCode);
  }

  Future<void> getCredentials() async {
    print("getCredentials");
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    print("getDeployedContract");
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Certificates"), _contractAddress);

    _generateCertificate = _contract.function("generateCertificate");
    // getTodos();
    // print("");
  }

  // getTodos() async {
  //   try {
  //     List totalTasksList = await _client.call(contract: _contract, function: _taskCount, params: []).catchError((e) {
  //       print(e);
  //     });
  //
  //     BigInt totalTasks = totalTasksList[0];
  //     taskCount = totalTasks.toInt();
  //     print(totalTasks);
  //     todos.clear();
  //     for (var i = 0; i < totalTasks.toInt(); i++) {
  //       var temp = await _client.call(contract: _contract, function: _todos, params: [BigInt.from(i)]);
  //       todos.add(Task(taskName: temp[0], isCompleted: temp[1]));
  //     }
  //
  //     isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  addCertificate(String taskNameData) async {
    print("taskNameData");
    notifyListeners();
    final res = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(contract: _contract, function: _generateCertificate, parameters: [taskNameData]),
    );
    print(res);
    // getTodos();
  }
}
