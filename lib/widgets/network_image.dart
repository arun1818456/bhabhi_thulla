
import 'package:cached_network_image/cached_network_image.dart';

import '../constant/export_file.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  final BoxFit boxFit;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 18,
    this.iconSize = 20,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl.isNotEmpty
          ? CachedNetworkImage(
        // cacheKey: imageUrl,
        imageUrl: imageUrl,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
            ),
          ),
        ),
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      )
          : _buildErrorWidget(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Padding(
        padding: EdgeInsets.all(17.0),
        child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: Colors.yellow,
            )),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: iconSize,
          ),
          Text(
            "no found",
            // style: w_400.copyWith(fontSize: 8, color: Colors.black),
          )
        ],
      ),
    );
  }
}
