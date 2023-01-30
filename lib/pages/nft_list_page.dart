import 'package:flutter/material.dart';
import 'package:nft_public_sale/app_provider.dart';
import 'package:nft_public_sale/models/nft.dart';
import 'package:nft_public_sale/pages/nft_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class NFTList extends StatelessWidget {
  const NFTList({
    required this.nftList,
    this.onRefresh,
    this.showAsEnabled = true,
    super.key,
  });

  final List<NFT>? nftList;
  final Future Function()? onRefresh;
  final bool showAsEnabled;

  @override
  Widget build(BuildContext context) {
    if (nftList == null) {
      return GridView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              color: Colors.black,
            ),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? Future.value,
      child: GridView.builder(
        itemCount: nftList!.length,
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          final nft = nftList![index];
          return GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(NFTDetailPage.routeName, arguments: nft),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'nft-${nft.id}',
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: nft.url,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                if (!nft.enabled && !showAsEnabled)
                  Container(
                    color: Colors.black.withOpacity(.5),
                    alignment: Alignment.center,
                    child: Text(
                      'No disponible',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
