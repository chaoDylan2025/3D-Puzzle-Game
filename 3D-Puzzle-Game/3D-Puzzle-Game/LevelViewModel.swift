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
    @Published var contentViewColor: Color = Color.black.opacity(0.6) // Changes color of ContentView's ZStack
    @Published var confirmedDifficulty: Bool = false // Difficulty confirmed by user
    @Published var sceneToDisplay: String = "" // Contains level to display
    @Published var currentTimer: String = "" // Contains timer based on selected difficulty
}
