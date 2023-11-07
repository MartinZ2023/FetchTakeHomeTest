//
//  DessertMenuViewModel.swift
//  FetchTakeHomeExercise
//
//  Created by Martin Zhao on 11/6/23.
//

import Foundation

import Combine

class DessertMenuViewModel: ObservableObject {
    @Published var meals: [Meal] = [] // Store the list of meals
    private var cancellables: Set<AnyCancellable> = []
    private var jsonData: Data?
    // Function to fetch dessert meals
    
    
    /*
        This function is used to call the Themealdb API and retrieve a list of meal(Dessert) with their name and ID info.
    */
    
    func downloadJSON() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.meals = mealsResponse.meals
                    }
                } catch {
                    // Handle decoding errors
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                // Handle the error
                print("Error downloading JSON: \(error)")
            }
        }.resume()
    }
    
    
    
    /*
        This function is used to call the Themealdb API and retrieve a detailed Info including Instruction and ingredients
     based on the food's specific ID.
    */
    
    func fetchMealDetails(for meal: Meal, completion: @escaping (MealDetails?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else {
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                
        
                
                do {
                    let detailsResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
                    
                    if let mealDetails = detailsResponse.meals.first {
                        
                        let ingredientsString = self.buildIngredientsString(mealDetails)
                         
                        completion(mealDetails)
                        
                    } else {
                        completion(nil)
                    }
                } catch {
                    // Handle decoding errors
                    print("Error decoding meal details: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                // Handle the error
                print("Error fetching meal details: \(error)")
                completion(nil)
            }
        }.resume()
        
    }
    
    /*
        This function is used to combine all of the ingredients and their according measures into a string to display in the
     SlideView.
    */
    
    func buildIngredientsString(_ mealDetails: MealDetails) -> String {
    
        let ingredients = mealDetails.getAll(s: "strIngredient")
        
        let measures = mealDetails.getAll(s: "strMeasure")
    

        let combinedString = zip(ingredients, measures)
            .map { "\($0) (\($1))" }
            .joined(separator: "; ")
        
        return combinedString
    }
}
