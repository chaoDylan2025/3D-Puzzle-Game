//
//  LevelViewModel.swift
//  3D-Puzzle-Game
//
//  Created by Dylan Chao on 4/10/25.
//

import SwiftUI

@MainActor
class LevelViewModel: ObservableObject {
    @Published var sceneToDisplay: String = ""
}
