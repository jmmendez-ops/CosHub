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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'costume': costume.toJson(),
      'mode': mode.name,
      'size': size,
      'quantity': quantity,
      'rentalDays': rentalDays,
      'rentalStartDate': rentalStartDate?.toIso8601String(),
    };
  }

  factory CartLineItem.fromJson(Map<String, dynamic> json) {
    return CartLineItem(
      id: json['id'] as String,
      costume: CostumeItem.fromJson(json['costume'] as Map<String, dynamic>),
      mode: json['mode'] == 'buy' ? OrderMode.buy : OrderMode.rent,
      size: json['size'] as String? ?? 'M',
      quantity: json['quantity'] as int? ?? 1,
      rentalDays: json['rentalDays'] as int? ?? 3,
      rentalStartDate: json['rentalStartDate'] != null
          ? DateTime.tryParse(json['rentalStartDate'] as String)
          : null,
    );
  }
}
