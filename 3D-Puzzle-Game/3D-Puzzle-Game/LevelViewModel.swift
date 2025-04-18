//
//  LevelViewModel.swift
//  3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/10/25.
//

import SwiftUI

@MainActor
class LevelViewModel: ObservableObject {
    @Published var showLevel: Bool = false // Shows level in ContentView
    @Published var contentViewColor: Color = Color.black // Changes color of ContentView's ZStack
    @Published var sceneToDisplay: String = "" // Contains level to display
}
