//
//  _D_Puzzle_GameApp.swift
//  3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/10/25.
//

import SwiftUI

@main
struct _D_Puzzle_GameApp: App {
    @StateObject var level = LevelViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(level)
        }
    }
}
