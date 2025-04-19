//
//  ContentView.swift
//  3D-Puzzle-Game
//
//  Created by Dylan Chao and Luke B. Dykstra on 4/10/25.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var level: LevelViewModel

    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                VStack (){
                    Spacer()
                    // Game Title
                    Text("3D Puzzle Game")
                    .font(.largeTitle)
                    .bold()
                    .navigationBarTitleDisplayMode(.inline)
                    .padding([.top, .bottom], 10)
                    Spacer()
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
                    Spacer()
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
