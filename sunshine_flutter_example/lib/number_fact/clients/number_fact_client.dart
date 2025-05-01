var numberFactClient = unimplementedFactClient;

final class NumberFactClient {
  Future<String> Function(int) factFor;
  NumberFactClient({required this.factFor});
}

final unimplementedFactClient = NumberFactClient(
  factFor: (number) async {
    throw UnimplementedError();
  },
);
