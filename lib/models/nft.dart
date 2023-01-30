class NFT {
  final String hash;
  final int id;
  bool enabled = false;

  String get url => 'https://ipfs.io/ipfs/$hash/$id.png';

  NFT({
    required this.hash,
    required this.id,
  });

  void setEnabled(bool enabled) {
    this.enabled = enabled;
  }
}
