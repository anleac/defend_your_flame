import 'package:defend_your_flame/constants/translations/app_strings.dart';
import 'package:defend_your_flame/core/flame/shop/purchasable.dart';

class AttackTotemPurchase extends Purchasable {
  static const int maxTotems = 2;

  AttackTotemPurchase(AppStrings appStrings)
      : super(
          name: appStrings.attackTotemName,
          description: appStrings.attackTotemDescription,
          cost: 120,
          maxPurchaseCount: maxTotems,
        );
}
