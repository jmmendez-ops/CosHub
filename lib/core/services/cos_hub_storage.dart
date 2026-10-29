import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_line_item.dart';

class CosHubStorage {
  static const String _keyWishlist = 'coshub_wishlist_ids';
  static const String _keyCart = 'coshub_cart_items';
  static const String _keyCategory = 'coshub_selected_category';
  static const String _keyModeFilter = 'coshub_selected_mode_filter';

  static Future<Set<String>> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_keyWishlist);
      if (list != null) {
        return list.toSet();
      }
    } catch (e) {
      debugPrint('[CosHubStorage] loadWishlist error: $e');
    }
    return {'prod-1'};
  }

  static Future<void> saveWishlist(Set<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_keyWishlist, ids.toList());
    } catch (e) {
      debugPrint('[CosHubStorage] saveWishlist error: $e');
    }
  }

  static Future<List<CartLineItem>> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_keyCart);
      if (jsonString != null && jsonString.isNotEmpty) {
        final decoded = jsonDecode(jsonString) as List<dynamic>;
        return decoded
            .map((item) =>
                CartLineItem.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('[CosHubStorage] loadCart error: $e');
    }
    return [];
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
}
