//
//  LevelSelection.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao and Luke B. Dykstra on 4/8/25.
//

import SwiftUI


struct LevelSelection: View {
    let view: String
    @Binding var path: NavigationPath
    @EnvironmentObject var currentLevel: LevelViewModel
    @Environment(\.dismiss) private var dismiss
    
    let levels: [String] = ["Level 1", "Level 2", "Level 3"];
    
    var body: some View {
        ZStack{
            // Display only if user has not selected a level
            if(!currentLevel.showLevel){
                VStack (){
                    // Game Title
                    Text("Select a Level")
                        .font(.title)
                        .bold()
                    Spacer()
                }.padding(.top, 70)
                VStack {
                    ForEach(levels, id:\.self) { level in
                        Button(level) {
                            levelSceneToDisplay(level: level, viewModel: currentLevel)
                            currentLevel.showLevel = true
                            currentLevel.playerWon = false
                        }
                        .frame(width: 60)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 15)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding([.top, .bottom], 25)
                    }
                }
            }
            else{
                VStack(){
                    // Top part of each level
                    VStack(){
                        VStack(){
                            if currentLevel.playerWon {
                                Text("Level Complete!").font(Font.custom("Calibri", size: 22))
                                Button("Back to Level Select") {
                                    currentLevel.showLevel = false
                                    currentLevel.playerWon = false
                                }
                                .padding(.horizontal, 50)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            }
                        }
                        GameView()
                            .environmentObject(currentLevel)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(!currentLevel.showLevel ? false : true)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(!currentLevel.showLevel ? Color.red.opacity(0.6): currentLevel.contentViewColor)
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
