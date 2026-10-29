import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_line_item.dart';

class CosHubStorage {
  static const String _keyWishlist = 'coshub_wishlist_ids';
  static const String _keyCart = 'coshub_cart_items';
  static const String _keyCategory = 'coshub_selected_category';
  static const String _keyModeFilter = 'coshub_selected_mode_filter';
  static const String _keyPaymentMethod = 'coshub_payment_method';
  static const String _keyGcashNumber = 'coshub_gcash_number';
  static const String _keyMayaNumber = 'coshub_maya_number';
  static const String _keyCardLast4 = 'coshub_card_last4';

  static Future<Set<String>?> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(_keyWishlist)) {
        final list = prefs.getStringList(_keyWishlist);
        return list?.toSet() ?? {};
      }
    } catch (e) {
      debugPrint('[CosHubStorage] loadWishlist error: $e');
    }
    return null;
  }

  static Future<void> saveWishlist(Set<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_keyWishlist, ids.toList());
    } catch (e) {
      debugPrint('[CosHubStorage] saveWishlist error: $e');
    }
  }

  static Future<List<CartLineItem>?> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(_keyCart)) {
        final jsonString = prefs.getString(_keyCart);
        if (jsonString != null && jsonString.isNotEmpty) {
          final decoded = jsonDecode(jsonString) as List<dynamic>;
          return decoded
              .map((item) =>
                  CartLineItem.fromJson(item as Map<String, dynamic>))
              .toList();
        }
        return [];
      }
    } catch (e) {
      debugPrint('[CosHubStorage] loadCart error: $e');
    }
    return null;
  }

  static Future<void> saveCart(List<CartLineItem> cart) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(cart.map((e) => e.toJson()).toList());
      await prefs.setString(_keyCart, encoded);
    } catch (e) {
      debugPrint('[CosHubStorage] saveCart error: $e');
    }
  }

  static Future<String?> loadCategory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyCategory);
    } catch (e) {
      debugPrint('[CosHubStorage] loadCategory error: $e');
    }
    return null;
  }

  static Future<void> saveCategory(String category) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyCategory, category);
    } catch (e) {
      debugPrint('[CosHubStorage] saveCategory error: $e');
    }
  }

  static Future<String?> loadModeFilter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyModeFilter);
    } catch (e) {
      debugPrint('[CosHubStorage] loadModeFilter error: $e');
    }
    return null;
  }

  static Future<void> saveModeFilter(String filter) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyModeFilter, filter);
    } catch (e) {
      debugPrint('[CosHubStorage] saveModeFilter error: $e');
    }
  }

  static Future<Map<String, String>> loadPaymentSettings() async {
    final Map<String, String> settings = {
      'method': 'GCash',
      'gcash': '0956 123 3881',
      'maya': '0918 888 4567',
      'card': '4821',
    };
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(_keyPaymentMethod)) {
        settings['method'] = prefs.getString(_keyPaymentMethod)!;
      }
      if (prefs.containsKey(_keyGcashNumber)) {
        settings['gcash'] = prefs.getString(_keyGcashNumber)!;
      }
      if (prefs.containsKey(_keyMayaNumber)) {
        settings['maya'] = prefs.getString(_keyMayaNumber)!;
      }
      if (prefs.containsKey(_keyCardLast4)) {
        settings['card'] = prefs.getString(_keyCardLast4)!;
      }
    } catch (e) {
      debugPrint('[CosHubStorage] loadPaymentSettings error: $e');
    }
    return settings;
  }

  static Future<void> savePaymentSettings({
    required String method,
    required String gcash,
    required String maya,
    required String card,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyPaymentMethod, method);
      await prefs.setString(_keyGcashNumber, gcash);
      await prefs.setString(_keyMayaNumber, maya);
      await prefs.setString(_keyCardLast4, card);
    } catch (e) {
      debugPrint('[CosHubStorage] savePaymentSettings error: $e');
    }
  }
}
