//
//  MealDBApiHandler.swift
//  FetchTakeHomeExercise
//
//  Created by Martin Zhao on 11/6/23.
//

import Foundation


/*
    This file serve as the placeholder for storing all the info retrieved from mealDB API.
*/


struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let idMeal: String
}

struct MealDetails: Codable {
    let strInstructions: String
    let strCategory: String
    let strMeal: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strTotal: String?
    
    func countNonEmptyStringProperties() -> Int {
            let mirror = Mirror(reflecting: self)
            var count = 0

            for (_, value) in mirror.children {
                if let stringValue = value as? String, !stringValue.isEmpty {
                    count += 1
                }
            }

            return count
        }
    
    
    
    func getAll(s: String) -> [String] {
            let mirror = Mirror(reflecting: self)
            var ingredients: [String] = []
            
            for case let (label?, value) in mirror.children {
                if label.hasPrefix(s), let ingredient = value as? String, !ingredient.isEmpty {
                    ingredients.append(ingredient)
                }
            }
            
            return ingredients
        }
    
    
    // Add any other properties from the JSON response
}

struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}
