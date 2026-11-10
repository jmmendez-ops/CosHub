# Live Context7 Documentation: shared_preferences

Library ID: `/websites/pub_dev_packages_shared_preferences`

### Overview
`shared_preferences` is used in COS HUB for local state persistence (`CosHubStorage`).

### Read/Write Pattern
```dart
final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setStringList('orders', serializedOrders);
final List<String>? ordersJson = prefs.getStringList('orders');
```

In test environment, always initialize:
```dart
SharedPreferences.setMockInitialValues({});
```
