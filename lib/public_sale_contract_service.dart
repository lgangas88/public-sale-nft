import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';

class PublicSaleContractService {
  late DeployedContract contract;

  final EthereumAddress contractAddr =
      EthereumAddress.fromHex(dotenv.env['PUBLIC_SALE_CONTRACT_ADDRESS']!);
  final List<ContractFunction> functions = [
    ContractFunction(
      'purchaseNftById',
      [
        FunctionParameter(
          '_id',
          parseAbiType('uint256'),
        ),
      ],
    ),
    const ContractFunction(
      '_testEvent',
      [],
    ),
    ContractFunction(
      'getEnableNFts',
      [],
      outputs: [
        FunctionParameter(
          '',
          parseAbiType('uint256[]'),
        ),
        FunctionParameter(
          '',
          parseAbiType('uint256'),
        ),
      ],
    ),
  ];
  final List<ContractEvent> events = [
    ContractEvent(
      true,
      'DeliverNft',
      [
        EventComponent(
          FunctionParameter(
            'winnerAccount',
            parseAbiType('address'),
          ),
          false,
        ),
        EventComponent(
          FunctionParameter(
            'nftId',
            parseAbiType('uint256'),
          ),
          false,
        ),
      ],
    ),
    ContractEvent(
      true,
      'TestEvent',
      [
        EventComponent(
          FunctionParameter(
            'test',
            parseAbiType('bool'),
          ),
          false,
        ),
      ],
    ),
  ];

  ContractFunction get purchaseNftByIdFunction =>
      contract.function('purchaseNftById');
  ContractFunction get testFunction => contract.function('_testEvent');
  ContractFunction get getEnableNFtsFunction =>
      contract.function('getEnableNFts');
  ContractEvent get deliverNFTEvent => contract.event('DeliverNft');
  ContractEvent get testNFTEvent => contract.event('TestEvent');

  PublicSaleContractService() {
    contract = DeployedContract(
      ContractAbi('PublicSale', functions, events),
      contractAddr,
    );
  }

  Future<Transaction> getPurchaseNFTByIdTransaction(
    int nftId,
    String address, {
    int nonce = 0,
  }) async {
    final accountAddress = EthereumAddress.fromHex(address);

    final transaction = Transaction.callContract(
      contract: contract,
      function: purchaseNftByIdFunction,
      parameters: [BigInt.from(nftId)],
      from: accountAddress,
      maxGas: 1000000,
      nonce: nonce,
    );
    return transaction;
  }

  Future<Transaction> testTransaction(String address) async {
    final accountAddress = EthereumAddress.fromHex(address);

    final transaction = Transaction.callContract(
      contract: contract,
      function: testFunction,
      parameters: [],
      from: accountAddress,
      maxGas: 1000000,
      // nonce: nonce,
    );
    return transaction;
  }
}
