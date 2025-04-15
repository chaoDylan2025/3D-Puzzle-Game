//
//  LevelSelection.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/8/25.
//

import SwiftUI


struct LevelSelection: View {
    let view: String
    @Binding var path: NavigationPath
    @EnvironmentObject var currentLevel: LevelViewModel
    @Environment(\.dismiss) private var dismiss
    
    let levels: [String] = ["Level 1", "Level 2", "Level 3", "Level 4"];
    
    var body: some View {
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
                    Button(level) {
                        levelSceneToDisplay(level: level, viewModel: currentLevel)
                        path.append("Difficulty")
                    }
                    .frame(width: 60)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .padding([.top, .bottom], 20)
                }
            }
        }
        .onAppear{
            if(currentLevel.confirmedDifficulty){
                currentLevel.showLevel = true
                path = NavigationPath() // Reset the navigation state
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Color.red.opacity(0.6))
    }
    
    func levelSceneToDisplay(level: String, viewModel: LevelViewModel){
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
}
 
 #Preview {
     @Previewable @State var path = NavigationPath()
     LevelSelection(view: "Play", path: $path)
     .environmentObject(LevelViewModel())
 }
