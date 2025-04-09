//
//  LevelSelection.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/8/25.
//

import SwiftUI

struct LevelSelection: View {
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
                        NavigationLink(destination: LevelSelection(), label: {
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
                    }
                    
                }
                
            }
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color.red.opacity(0.6))
        }
    }
}

#Preview {
    LevelSelection()
}
