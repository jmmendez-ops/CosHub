import 'costume_item.dart';

enum OrderStatus {
  placed('Order Placed'),
  confirmed('Order Confirmed'),
  preparing('Costume & Props Prepped'),
  inTransit('Out for Delivery / Courier In Transit'),
  readyForMeetup('Ready for Convention Meetup'),
  delivered('Delivered / Active Rental'),
  returning('Return In Transit'),
  returned('Returned & Inspected'),
  completed('Completed / Deposit Refunded');

  final String label;
  const OrderStatus(this.label);
}

enum DeliveryMethod {
  lalamove('Lalamove Express (Same Day)'),
  grabExpress('Grab Express (Same Day)'),
  jnt('J&T Express Provincial'),
  conventionMeetup('Convention Floor Meetup');

  final String label;
  const DeliveryMethod(this.label);
}

class CourierDetails {
  final String? riderName;
  final String? riderPhone;
  final String? vehiclePlate;
  final String? trackingNumber;
  final String? estimatedDelivery;
  final String? meetupLocation;
  final String? meetupTimeWindow;

  const CourierDetails({
    this.riderName,
    this.riderPhone,
    this.vehiclePlate,
    this.trackingNumber,
    this.estimatedDelivery,
    this.meetupLocation,
    this.meetupTimeWindow,
  });

  CourierDetails copyWith({
    String? riderName,
    String? riderPhone,
    String? vehiclePlate,
    String? trackingNumber,
    String? estimatedDelivery,
    String? meetupLocation,
    String? meetupTimeWindow,
  }) {
    return CourierDetails(
      riderName: riderName ?? this.riderName,
      riderPhone: riderPhone ?? this.riderPhone,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      meetupLocation: meetupLocation ?? this.meetupLocation,
      meetupTimeWindow: meetupTimeWindow ?? this.meetupTimeWindow,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'riderName': riderName,
      'riderPhone': riderPhone,
      'vehiclePlate': vehiclePlate,
      'trackingNumber': trackingNumber,
      'estimatedDelivery': estimatedDelivery,
      'meetupLocation': meetupLocation,
      'meetupTimeWindow': meetupTimeWindow,
    };
  }

  factory CourierDetails.fromJson(Map<String, dynamic> json) {
    return CourierDetails(
      riderName: json['riderName'] as String?,
      riderPhone: json['riderPhone'] as String?,
      vehiclePlate: json['vehiclePlate'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      estimatedDelivery: json['estimatedDelivery'] as String?,
      meetupLocation: json['meetupLocation'] as String?,
      meetupTimeWindow: json['meetupTimeWindow'] as String?,
    );
  }
}

class TrackingMilestone {
  final String title;
  final String subtitle;
  final String timestamp;
  final bool isCompleted;
  final bool isCurrent;

  const TrackingMilestone({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.isCompleted,
    this.isCurrent = false,
  });

  TrackingMilestone copyWith({
    String? title,
    String? subtitle,
    String? timestamp,
    bool? isCompleted,
    bool? isCurrent,
  }) {
    return TrackingMilestone(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      timestamp: timestamp ?? this.timestamp,
      isCompleted: isCompleted ?? this.isCompleted,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'timestamp': timestamp,
      'isCompleted': isCompleted,
      'isCurrent': isCurrent,
    };
  }

  factory TrackingMilestone.fromJson(Map<String, dynamic> json) {
    return TrackingMilestone(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      isCurrent: json['isCurrent'] as bool? ?? false,
    );
  }
}

class OrderRecord {
  final String id;
  final String itemTitle;
  final String itemCategory;
  final String sellerName;
  final String sellerHandle;
  final String sellerLocation;
  final String? heroImageUrl;
  final List<String> inclusions;
  final OrderMode orderMode;
  final OrderStatus status;
  final DeliveryMethod deliveryMethod;
  final CourierDetails courierDetails;
  final int totalAmount;
  final int securityDeposit;
  final bool isDepositRefunded;
  final int rentalDays;
  final String? rentalStartDate;
  final String? rentalEndDate;
  final String createdAt;
  final List<TrackingMilestone> milestones;

  const OrderRecord({
    required this.id,
    required this.itemTitle,
    required this.itemCategory,
    required this.sellerName,
    required this.sellerHandle,
    required this.sellerLocation,
    this.heroImageUrl,
    this.inclusions = const [],
    required this.orderMode,
    required this.status,
    required this.deliveryMethod,
    this.courierDetails = const CourierDetails(),
    required this.totalAmount,
    this.securityDeposit = 0,
    this.isDepositRefunded = false,
    this.rentalDays = 0,
    this.rentalStartDate,
    this.rentalEndDate,
    required this.createdAt,
    this.milestones = const [],
  });

  bool get isActive => status != OrderStatus.completed;
  bool get isRental => orderMode == OrderMode.rent;

  OrderRecord copyWith({
    String? id,
    String? itemTitle,
    String? itemCategory,
    String? sellerName,
    String? sellerHandle,
    String? sellerLocation,
    String? heroImageUrl,
    List<String>? inclusions,
    OrderMode? orderMode,
    OrderStatus? status,
    DeliveryMethod? deliveryMethod,
    CourierDetails? courierDetails,
    int? totalAmount,
    int? securityDeposit,
    bool? isDepositRefunded,
    int? rentalDays,
    String? rentalStartDate,
    String? rentalEndDate,
    String? createdAt,
    List<TrackingMilestone>? milestones,
  }) {
    return OrderRecord(
      id: id ?? this.id,
      itemTitle: itemTitle ?? this.itemTitle,
      itemCategory: itemCategory ?? this.itemCategory,
      sellerName: sellerName ?? this.sellerName,
      sellerHandle: sellerHandle ?? this.sellerHandle,
      sellerLocation: sellerLocation ?? this.sellerLocation,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      inclusions: inclusions ?? this.inclusions,
      orderMode: orderMode ?? this.orderMode,
      status: status ?? this.status,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      courierDetails: courierDetails ?? this.courierDetails,
      totalAmount: totalAmount ?? this.totalAmount,
      securityDeposit: securityDeposit ?? this.securityDeposit,
      isDepositRefunded: isDepositRefunded ?? this.isDepositRefunded,
      rentalDays: rentalDays ?? this.rentalDays,
      rentalStartDate: rentalStartDate ?? this.rentalStartDate,
      rentalEndDate: rentalEndDate ?? this.rentalEndDate,
      createdAt: createdAt ?? this.createdAt,
      milestones: milestones ?? this.milestones,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemTitle': itemTitle,
      'itemCategory': itemCategory,
      'sellerName': sellerName,
      'sellerHandle': sellerHandle,
      'sellerLocation': sellerLocation,
      'heroImageUrl': heroImageUrl,
      'inclusions': inclusions,
      'orderMode': orderMode.name,
      'status': status.name,
      'deliveryMethod': deliveryMethod.name,
      'courierDetails': courierDetails.toJson(),
      'totalAmount': totalAmount,
      'securityDeposit': securityDeposit,
      'isDepositRefunded': isDepositRefunded,
      'rentalDays': rentalDays,
      'rentalStartDate': rentalStartDate,
      'rentalEndDate': rentalEndDate,
      'createdAt': createdAt,
      'milestones': milestones.map((m) => m.toJson()).toList(),
    };
  }

  factory OrderRecord.fromJson(Map<String, dynamic> json) {
    final statusStr = json['status'] as String?;
    final methodStr = json['deliveryMethod'] as String?;
    final modeStr = json['orderMode'] as String?;

    return OrderRecord(
      id: json['id'] as String? ?? '',
      itemTitle: json['itemTitle'] as String? ?? '',
      itemCategory: json['itemCategory'] as String? ?? '',
      sellerName: json['sellerName'] as String? ?? '',
      sellerHandle: json['sellerHandle'] as String? ?? '',
      sellerLocation: json['sellerLocation'] as String? ?? '',
      heroImageUrl: json['heroImageUrl'] as String?,
      inclusions: (json['inclusions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      orderMode: modeStr == 'buy' ? OrderMode.buy : OrderMode.rent,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == statusStr,
        orElse: () => OrderStatus.placed,
      ),
      deliveryMethod: DeliveryMethod.values.firstWhere(
        (e) => e.name == methodStr,
        orElse: () => DeliveryMethod.lalamove,
      ),
      courierDetails: json['courierDetails'] != null
          ? CourierDetails.fromJson(
              json['courierDetails'] as Map<String, dynamic>)
          : const CourierDetails(),
      totalAmount: json['totalAmount'] as int? ?? 0,
      securityDeposit: json['securityDeposit'] as int? ?? 0,
      isDepositRefunded: json['isDepositRefunded'] as bool? ?? false,
      rentalDays: json['rentalDays'] as int? ?? 0,
      rentalStartDate: json['rentalStartDate'] as String?,
      rentalEndDate: json['rentalEndDate'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((m) =>
                  TrackingMilestone.fromJson(m as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}
