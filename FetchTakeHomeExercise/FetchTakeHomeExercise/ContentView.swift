//
//  ContentView.swift
//  FetchTakeHomeExercise
//
//  Created by Martin Zhao on 11/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isSlideUpCardVisible = false
    @State private var selectedInstruction : String = ""
    @State private var selectedName : String = ""
    @State private var selectedIngredient : String = ""
    @ObservedObject var viewModel = DessertMenuViewModel()
    @State private var jsonData: Data?
    @State private var meals: [Meal] = []
    
    var body: some View {
        VStack {
            Text("Dessert Menu")
            
            ScrollView() {
                ForEach(viewModel.meals, id: \.idMeal) { meal in
                    VStack {
                        HStack() {
                            Image(systemName: "oven")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            
                            Text(meal.strMeal)
                        }
                        .padding()
                        .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                        .border(Color.black, width: 1)
                        
                    }
                    .onTapGesture {
                        viewModel.fetchMealDetails(for: meal){ mealDetails in
                            if let mealDetails = mealDetails {
                                selectedName=meal.strMeal
                                selectedInstruction=mealDetails.strInstructions
                                selectedIngredient = viewModel.buildIngredientsString(mealDetails)
                            }
                            isSlideUpCardVisible = true
                        }
                    }
                }
                
            }
            .onAppear{
                viewModel.downloadJSON()
            }
            .overlay(
                Group {
                    if isSlideUpCardVisible {
                        SlideView(isShowing: $isSlideUpCardVisible, selectName: $selectedName,selectInstruction: $selectedInstruction,selectIngreident:$selectedIngredient)
                    }
                }
            )
            if(isSlideUpCardVisible){
                Text("To go back to main page, click the close button")
            }
            else{
                Text("To see the details of each dessert, click the icon")
            }
        }
    }
    
}

