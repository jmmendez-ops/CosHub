import 'costume_item.dart';

class CartLineItem {
  final String id;
  final CostumeItem costume;
  final OrderMode mode;
  final String size;
  int quantity;
  int rentalDays;
  DateTime? rentalStartDate;

  CartLineItem({
    required this.id,
    required this.costume,
    required this.mode,
    required this.size,
    this.quantity = 1,
    this.rentalDays = 3,
    this.rentalStartDate,
  });

  int get itemSubtotal {
    if (mode == OrderMode.buy) {
      return costume.buyPrice * quantity;
    } else {
      return (costume.rentPricePerDay * rentalDays) * quantity;
    }
  }

  int get totalDeposit {
    return mode == OrderMode.rent ? (costume.securityDeposit * quantity) : 0;
  }
}
