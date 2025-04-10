//
//  DifficultySettings.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/8/25.
//

import SwiftUI

struct DifficultySettings: View {
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
        NavigationStack {
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
                    ForEach(difficultyArr) { setting in
                        NavigationLink(destination: LevelSelection(), label: {
                            VStack {
                                Text(setting.difficulty)
                                .frame(width: 100)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 15)
                                .background(setting.color)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            }.padding([.top, .bottom], 20)
                        }).padding([.bottom], 20)
                    }
                    
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.red.opacity(0.6))
        }
    }
}

#Preview {
    DifficultySettings()
}
