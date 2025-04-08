//
//  LevelDisplay.swift
//  SwiftUI-3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/5/25.
//

import SwiftUI
import SceneKit

struct LevelDisplay: View {
    var body: some View {
        ZStack{
            SceneView(
                scene: SCNScene(named: "art.scnassets/level1.scn"),
                options: [.allowsCameraControl, .autoenablesDefaultLighting],
                preferredFramesPerSecond: 60,
                antialiasingMode: .multisampling4X,
            )
        }
    }
}

#Preview {
    LevelDisplay()
}
