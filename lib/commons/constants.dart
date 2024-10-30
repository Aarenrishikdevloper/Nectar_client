import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';

class GroceryCategory {
   final String name;
   final String imagePath; // Replace with actual image paths

   GroceryCategory(this.name, this.imagePath);
}
class constants{
   static String baseurl= "https://nectar-backend.onrender.com/api";
   static const jwttoken = 'JKkdxihxcbnjcbjcbcc';
   static const api_key = 'rzp_test_TQ1F3CGidLSzBo';
  static List<GroceryCategory> groceryCategories = [
      GroceryCategory('Fruits', 'assets/img/apple.png'),
      GroceryCategory('Vegetable', 'assets/img/ginger.png'),
      GroceryCategory('Dairy', 'assets/img/dairy_eggs.png'),
      GroceryCategory('Grains', 'assets/img/pulses.png'),
      GroceryCategory('Snacks', 'assets/img/bakery_snacks.png'),
     GroceryCategory('Non-Veg', 'assets/img/meat_fish.png'), // Add Meat category
     GroceryCategory('Frozen Foods', 'assets/img/frozen-food.png'), // Add Frozen Foods category
     GroceryCategory('Beverages', 'assets/img/beverages.png'), // Add Beverages category
     GroceryCategory('Cooking Oil', 'assets/img/cooking_oil.png'), // Add Household category
     GroceryCategory('Bakery', 'assets/img/bakery_snacks.png'),
    GroceryCategory('Dried Fruits', 'assets/img/almonds.png'),
    GroceryCategory("Pet Supplies", 'assets/img/pet-supplies.png')



   ];
   static List<Color> colors = [
   Color(0xFFFFE5CC), // Light Orange
   Color(0xFFD6EAF8),
   Tcolor.primary.withOpacity(0.3),
     Color(0xFFFFF2CC), // Light Yellow
     Color(0xFFFFF3E0), // Light Apricot
     Color(0xFFE3F2FD), // Light Sky Blue
     Color(0xFFF5E0D2), // Light Peach
     Color(0xFFF2F2F2),
     Color(0xFFE8F5E9),
     Color(0xFFFAFAD2)



   ];
   List<String> northeastIndiaCities = [
     'Guwahati',        // Assam
     'Dispur',          // Assam (Capital of Assam)
     'Silchar',         // Assam
     'Dibrugarh',       // Assam
     'Tezpur',          // Assam
     'Jorhat',          // Assam
     'Imphal',          // Manipur
     'Kakching',        // Manipur
     'Aizawl',          // Mizoram
     'Kohima',          // Nagaland
     'Dimapur',         // Nagaland
     'Shillong',        // Meghalaya
     'Sibsagar',         //Assam
     'Tura',              // Meghalaya
     "Tinsukia",          //Assam
     'Agartala',        // Tripura
     'Udaipur',         // Tripura
     'Itanagar',        // Arunachal Pradesh
     'Naharlagun',      // Arunachal Pradesh
     'Bomdila',         // Arunachal Pradesh
     'Ziro',            // Arunachal Pradesh
     'Pasighat'         // Arunachal Pradesh
   ];
   List<String> northeastIndiaStatesWithoutSikkim = [
     'Arunachal Pradesh',
     'Assam',
     'Manipur',
     'Meghalaya',
     'Mizoram',
     'Nagaland',
     'Tripura'
   ];


}



