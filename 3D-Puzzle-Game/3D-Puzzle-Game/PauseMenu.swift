//
//  PuaseMenu.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/10/25.
//

import SwiftUI

struct PauseMenu: View {
    var body: some View {
        VStack {
            Text("Paused")
                .font(.largeTitle)
                .bold()
                .padding([.top], 50)
        }
        VStack{
            Button("Resume"){
                
            }
            .frame(width: 65.0)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            
            Spacer()
            
            Button("Restart"){
                
            }
            .frame(width: 65.0)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            
            Spacer()
            
            Button("Quit"){
                
            }
            .frame(width: 65.0)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            Spacer()
        }.padding([.top], 75)
        Spacer()
    }
}

#Preview {
    PauseMenu()
}
