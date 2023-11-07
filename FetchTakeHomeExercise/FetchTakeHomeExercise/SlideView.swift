//
//  SlideView.swift
//  FetchTakeHomeExercise
//
//  Created by Martin Zhao on 11/6/23.
//

import SwiftUI

struct SlideView: View {
    @Binding var isShowing: Bool
    @Binding var selectName: String
    @Binding var selectInstruction: String
    @Binding var selectIngreident: String
    var body: some View {
        
            ZStack {
                Color.white
                
                
                ScrollView{
                    VStack(alignment: .listRowSeparatorLeading){
                        HStack(alignment: .firstTextBaseline){
                            Text("Food Name:")
                            
                            Text(selectName)
                            
                        }
                        .padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Ingredients:")
                            Text(selectIngreident)
                            
                        }
                        .padding()
                        
                        HStack(alignment: .firstTextBaseline){
                            Text("Instruction:")
                            
                            Text(selectInstruction)
                            
                            
                        }
                        .padding()
                        
                    }
                }
                
                VStack{
                    HStack {
                        Spacer()
                        Button("Close") {
                            withAnimation {
                                isShowing = false
                            }
                        }
                        .padding(.trailing)
                    }
                    Spacer()
                }
            }
            .cornerRadius(20)
            .padding()
            .background(Color.gray)
        
        }
    }

