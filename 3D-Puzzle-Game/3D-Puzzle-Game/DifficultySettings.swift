//
//  DifficultySettings.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/8/25.
//

import SwiftUI


struct DifficultySettings: View {
    @EnvironmentObject var currentLevel: LevelViewModel
    @Environment(\.dismiss) private var dismiss
    // Creates a difficulty name and color
    struct DifficultySetting: Identifiable {
        var difficulty: String
        var color: Color
        var id: String { difficulty }
     }
 
     // Contains each difficulty and its colors
     let difficultyArr: [DifficultySetting] = [
     DifficultySetting(difficulty: "Easy", color: Color.green),
     DifficultySetting(difficulty: "Medium", color: Color.yellow),
     DifficultySetting(difficulty: "Hard", color: Color.red)
     ]
 
     var body: some View {
         // Display difficulty settings view
         if(!currentLevel.confirmedDifficulty){
             ZStack{
                 VStack (spacing: 20){
                     // Game Title
                     Text("Select a difficulty")
                     .font(.title)
                     .bold()
                     .frame(width: 250)
                     .padding(.horizontal, 50)
                     .padding(.vertical, 15)
                     .background(Color.green)
                     .padding([.top], 20)
                     Spacer()
                 }
     
                 VStack {
                     // Displays each difficulty
                     ForEach(difficultyArr) { setting in
                         // Creates a button structure
                         VStack {
                             Text(setting.difficulty)
                             .frame(width: 100)
                             .padding(.horizontal, 50)
                             .padding(.vertical, 15)
                             .background(setting.color)
                             .foregroundColor(.white)
                             .clipShape(Capsule())
                         }.padding([.top, .bottom], 20)
                         .simultaneousGesture(TapGesture().onEnded{
                             currentLevel.confirmedDifficulty = true
                             setDifficultyTimer(difficulty: setting.difficulty)
                             dismiss()
                         })
                    }.padding([.bottom], 20)
                 }
            }
             .containerRelativeFrame([.horizontal, .vertical])
             .background(Color.red.opacity(0.6))
        }
    }
    
    
    func setDifficultyTimer(difficulty: String){
        switch(difficulty){
            case "Easy":
                currentLevel.currentTimer = "2:00"
                break
                
            case "Medium":
                currentLevel.currentTimer = "1:30"
                break
            
            case "Hard":
            currentLevel.currentTimer = "1:00"
                break
            
            default:
                break
        }
    }
 }
 
 #Preview {
     DifficultySettings()
     .environmentObject(LevelViewModel())
 }
