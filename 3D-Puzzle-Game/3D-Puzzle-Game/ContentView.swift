//
//  ContentView.swift
//  3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/10/25.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var level: LevelViewModel
    let showMainMenu = false
    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                VStack (spacing: 60){
                    // Game Title
                    Text("3D Puzzle Game")
                    .font(.largeTitle)
                    .bold()
                    .navigationBarTitleDisplayMode(.inline)
                    .padding([.top, .bottom], 100)
                    
                    Button("Play"){
                        path.append("Play")
                    }
                    .frame(width: 60)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .navigationDestination(for: String.self){ view in
                        if(view == "Play"){
                            LevelSelection(view: view, path: $path)
                        }
                    }
                }
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.red.opacity(0.6))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LevelViewModel())
}
