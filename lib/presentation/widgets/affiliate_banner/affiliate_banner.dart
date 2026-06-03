import "package:cached_network_image/cached_network_image.dart";
import "package:easy_localization/easy_localization.dart";
import "package:esim_open_source/app/app.locator.dart";
import "package:esim_open_source/data/remote/responses/affiliate/affiliate_info_response_model.dart";
import "package:esim_open_source/domain/repository/services/local_storage_service.dart";
import "package:esim_open_source/translations/locale_keys.g.dart";
import "package:esim_open_source/utils/banner_translation_helper.dart";
import "package:flutter/material.dart";

/// Affiliate co-branded banner shown above the checkout sheet (and reusable
/// elsewhere) when a promo code resolves to an active affiliate. Mirrors the
/// web AffiliateBanner component: logo, "🎉 In partnership with <name>",
/// optional locale-resolved custom banner text, dismissible per affiliate.
class AffiliateBannerWidget extends StatefulWidget {
  const AffiliateBannerWidget({
    required this.affiliate,
    required this.locale,
    super.key,
  });

  final AffiliateInfoResponseModel affiliate;
  final String locale;

  @override
  State<AffiliateBannerWidget> createState() => _AffiliateBannerWidgetState();
}

class _AffiliateBannerWidgetState extends State<AffiliateBannerWidget> {
  bool _hidden = false;

  @override
  void initState() {
    super.initState();
    _hidden = _isClosedForAffiliate(widget.affiliate.id);
  }

  static List<String> _readClosedIds() {
    final String raw = locator<LocalStorageService>()
            .getString(LocalStorageKeys.closedAffiliateBanners) ??
        "";
    if (raw.isEmpty) return <String>[];
    return raw.split(",").where((String s) => s.isNotEmpty).toList();
  }

  static bool _isClosedForAffiliate(String? affiliateId) {
    if (affiliateId == null || affiliateId.isEmpty) return false;
    return _readClosedIds().contains(affiliateId);
  }

  Future<void> _close() async {
    final String? affiliateId = widget.affiliate.id;
    if (affiliateId != null && affiliateId.isNotEmpty) {
      final List<String> ids = _readClosedIds();
      if (!ids.contains(affiliateId)) {
        ids.add(affiliateId);
        await locator<LocalStorageService>().setString(
          LocalStorageKeys.closedAffiliateBanners,
          ids.join(","),
        );
      }
    }
    if (mounted) {
      setState(() => _hidden = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hidden) return const SizedBox.shrink();

    final String? bannerText = BannerTranslationHelper.resolve(
      widget.affiliate.customBannerText,
      widget.locale,
    );
    final String name = widget.affiliate.name ?? "";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: <Widget>[
          if (widget.affiliate.logoUrl != null &&
              widget.affiliate.logoUrl!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: widget.affiliate.logoUrl!,
              width: 40,
              height: 20,
              fit: BoxFit.contain,
              errorWidget: (BuildContext _, String __, Object ___) =>
                  const SizedBox(width: 40, height: 20),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "🎉 ${LocaleKeys.affiliate_partnerWith.tr()} $name",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (bannerText != null && bannerText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      bannerText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16),
            onPressed: _close,
            tooltip: "Close",
          ),
        ],
      ),
    );
  }
}
