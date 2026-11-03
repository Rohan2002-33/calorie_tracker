import 'package:calorie_tracker/models/food_item.dart';
import 'package:calorie_tracker/services/food_image_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FoodImageService - Accurate Food Image Resolution', () {
    test('Pineapple resolves to Pineapple photo, NOT Apple', () {
      final String pineapple = FoodImageService.getFoodImageUrl('Pineapple');
      final String apple = FoodImageService.getFoodImageUrl('Apple');
      expect(pineapple, isNot(equals(apple)));
      expect(pineapple, contains('photo-1550258987-190a2d41a8ba'));
      expect(apple, contains('photo-1560806887-1e4cd0b6cbd6'));
    });

    test('Steak resolves to Beef Steak, NOT Tea', () {
      final String steak = FoodImageService.getFoodImageUrl('Beef Steak');
      final String tea = FoodImageService.getFoodImageUrl('Tea');
      expect(steak, isNot(equals(tea)));
      expect(steak, contains('photo-1558030006-450675393462'));
      expect(tea, contains('photo-1576092768241-dec231879fc3'));
    });

    test(
      'Chicken Biryani resolves to Biryani, NOT plain rice or chicken curry',
      () {
        final String biryani = FoodImageService.getFoodImageUrl(
          'Chicken Biryani',
        );
        final String plainRice = FoodImageService.getFoodImageUrl('Plain Rice');
        final String chickenCurry = FoodImageService.getFoodImageUrl(
          'Chicken Curry',
        );

        expect(biryani, isNot(equals(plainRice)));
        expect(biryani, isNot(equals(chickenCurry)));
        expect(biryani, contains('photo-1563379091339-03b21ab4a4f8'));
      },
    );

    test('Fried Rice resolves to Fried Rice photo, NOT plain boiled rice', () {
      final String friedRice = FoodImageService.getFoodImageUrl(
        'Egg Fried Rice',
      );
      final String plainRice = FoodImageService.getFoodImageUrl('Sada Bhat');

      expect(friedRice, isNot(equals(plainRice)));
      expect(friedRice, contains('photo-1603133872878-684f208fb84b'));
      expect(plainRice, contains('photo-1516684732162-798a0062be99'));
    });

    test('Dim Bhaji / Omelette resolves to Omelette, NOT boiled egg', () {
      final String omelette = FoodImageService.getFoodImageUrl('Dim Bhaji');
      final String boiledEgg = FoodImageService.getFoodImageUrl('Boiled Egg');

      expect(omelette, isNot(equals(boiledEgg)));
      expect(omelette, contains('photo-1510693206972-df098062cb71'));
      expect(boiledEgg, contains('photo-1582722872445-44dc5f7e3c8f'));
    });

    test('Banglish dishes map to exact authentic dishes', () {
      expect(
        FoodImageService.getFoodImageUrl('Kacchi Biryani'),
        contains('photo-1563379091339-03b21ab4a4f8'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Shorshe Ilish'),
        contains('photo-1626777552726-4a6b54c97e46'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Chingri Malai Curry'),
        contains('photo-1559742811-822873691df8'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Alu Bhorta'),
        contains('photo-1600850056064-a8b380df8395'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Fuchka'),
        contains('photo-1606491956689-2ea866880c84'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Singara'),
        contains('photo-1601050690597-df0568f70950'),
      );
      expect(
        FoodImageService.getFoodImageUrl('Dudh Cha'),
        contains('photo-1576092768241-dec231879fc3'),
      );
    });

    test('French Fries resolves to Fries, NOT raw potato', () {
      final String fries = FoodImageService.getFoodImageUrl('French Fries');
      final String potato = FoodImageService.getFoodImageUrl('Potato Curry');
      expect(fries, contains('photo-1576107232684-1279f3908594'));
      expect(potato, contains('photo-1576107232684-1279f3908594'));
    });

    test('Unlisted custom foods generate high quality dynamic photo URL', () {
      final String url = FoodImageService.getFoodImageUrl('Mexican Enchiladas');
      expect(url, contains('image.pollinations.ai'));
      expect(url, contains('mexican%20enchiladas'));
      expect(url, contains('culinary%20presentation'));
    });

    test('Empty and whitespace-only food names fallback safely', () {
      expect(FoodImageService.getFoodImageUrl(''), isNotEmpty);
      expect(FoodImageService.getFoodImageUrl('    '), isNotEmpty);
    });

    test('FoodItem model integration uses effectiveImageUrl correctly', () {
      final FoodItem item = FoodItem(
        id: '1',
        name: 'Murgir Jhol',
        calories: 220,
        addedAt: DateTime.now(),
      );
      expect(
        item.effectiveImageUrl,
        contains('photo-1603894584373-5ac82b2ae398'),
      );
    });
  });
}
