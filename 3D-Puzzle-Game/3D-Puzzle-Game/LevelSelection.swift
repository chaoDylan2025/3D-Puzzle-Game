//
//  LevelSelection.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/8/25.
//

import SwiftUI

struct LevelSelection: View {
    @EnvironmentObject var currentLevel: LevelViewModel
    let levels: [String] = ["Level 1", "Level 2", "Level 3", "Level 4"];
    var body: some View {
        NavigationStack {
            ZStack{
                VStack (spacing: 20){
                    // Game Title
                    Text("Select a Level")
                        .font(.title)
                        .bold()
                        .padding([.top], 20)
                    Spacer()
                }
                
                VStack {
                    ForEach(levels, id:\.self) { level in
                        NavigationLink(destination: DifficultySettings(), label: {
                            VStack {
                                Text(level)
                                .frame(width: 60)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            }.padding([.top, .bottom], 20)
                        }).padding([.bottom], 20)
                        .simultaneousGesture(TapGesture().onEnded{
                            levelSceneToDisplay(level: level, viewModel: currentLevel)
                        })
                    }
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.red.opacity(0.6))
        }
    }
}

@MainActor func levelSceneToDisplay(level: String, viewModel: LevelViewModel){
    switch(level){
        case "Level 1":
            viewModel.sceneToDisplay = "art.scnassets/level1.scn"
            break
        case "Level 2":
            viewModel.sceneToDisplay = "art.scnassets/level2.scn"
            break
        case "Level 3":
            viewModel.sceneToDisplay = "art.scnassets/level3.scn"
            break
        case "Level 4":
            viewModel.sceneToDisplay = "art.scnassets/level4.scn"
            break
        default:
            break
    }
}

#Preview {
    LevelSelection()
        .environmentObject(LevelViewModel())
}
