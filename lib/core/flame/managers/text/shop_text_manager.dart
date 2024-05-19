import 'package:defend_your_flame/constants/theming_constants.dart';
import 'package:defend_your_flame/core/flame/managers/text/text_manager.dart';
import 'package:flame/text.dart';

class ShopTextManager {
  static final TextPaint _canPurchaseRenderer = TextManager.smallSubHeaderRenderer;
  static final TextPaint _cantAffordRenderer =
      TextManager.copyWith(_canPurchaseRenderer, color: ThemingConstants.cantAffordColour);
  static final TextPaint _alreadyPurchasedRenderer =
      TextManager.copyWith(_canPurchaseRenderer, color: ThemingConstants.purchasedItemColour);

  static TextPaint get canPurchaseRenderer => _canPurchaseRenderers.first;
  static TextPaint get cantAffordRenderer => _cantAffordRenderers.first;
  static TextPaint get alreadyPurchasedRenderer => _alreadyPurchasedRenderers.first;

  static TextPaint get canPurchaseRendererHovered => _canPurchaseRenderers[1];
  static TextPaint get cantAffordRendererHovered => _cantAffordRenderers[1];
  static TextPaint get alreadyPurchasedRendererHovered => _alreadyPurchasedRenderers[1];

  static TextPaint get canPurchaseRendererDisabled => _canPurchaseRenderers[2];
  static TextPaint get cantAffordRendererDisabled => _cantAffordRenderers[2];
  static TextPaint get alreadyPurchasedRendererDisabled => _alreadyPurchasedRenderers[2];

  static final List<TextPaint> _alreadyPurchasedRenderers = TextManager.getButtonRenderers(_alreadyPurchasedRenderer);
  static final List<TextPaint> _canPurchaseRenderers = TextManager.getButtonRenderers(_canPurchaseRenderer);
  static final List<TextPaint> _cantAffordRenderers = TextManager.getButtonRenderers(_cantAffordRenderer);
}
