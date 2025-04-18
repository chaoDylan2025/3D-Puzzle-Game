//
//  GameView.swift
//  3D-Puzzle-Game
//
//  Created by Luke B. Dykstra on 4/15/25.
//

import SwiftUI
import SceneKit

struct GameView: View {
    @EnvironmentObject var level: LevelViewModel
    var sceneViewWrapper = SceneViewWrapper()
    
    var body: some View {
        sceneViewWrapper
    }
}

// The SceneViewWrapper returns a SceneView but adds additional functionality,
// like tap and drag movement, position snapping, and level complete detection
struct SceneViewWrapper: UIViewRepresentable {
    @EnvironmentObject var level: LevelViewModel
    
    func makeUIView(context: Context) -> SCNView {
        // Create the scene, scene view, and load the level scene to display
        let sceneView = SCNView()
        let scene = SCNScene(named: level.sceneToDisplay)

        // Set the scene options
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling4X
        sceneView.preferredFramesPerSecond = 60

        // Create a PanGestureRecognizer that works with the Coordinator class and
        // calls the Coordinator.handlePan function
        let panGesture = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePan(_:))
        )

        // Add the gesture recognizer to the scene view
        sceneView.addGestureRecognizer(panGesture)
        // Add the scene view to the coordinator
        context.coordinator.sceneView = sceneView
        // Return the modified scene view
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sceneToDisplay: level.sceneToDisplay, level: level)
    }

    // The Coordinator acts as a middleman between the gesture recognizer and scene view
    // It handles dragging and snapping, and win detection
    class Coordinator: NSObject {
        weak var sceneView: SCNView?
        var selectedNode: SCNNode?
        var lastHitPosition: SCNVector3?
        var tagPairs: [String : String] = [:]
        var sceneToDisplay: String
        var level: LevelViewModel

        // Dictionary to store level file names and their associated puzzle piece counts
        let levelPieceCounts: [String : Int] = [
            "art.scnassets/level1.scn" : 4,
            "art.scnassets/level2.scn" : 4,
            "art.scnassets/level3.scn" : 9
        ]
        
        init (sceneToDisplay: String, level: LevelViewModel) {
            self.sceneToDisplay = sceneToDisplay
            self.level = level
        }

        // Given the gestureRecognizer, handles the start, change, and end state of the gesture
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sceneView = sceneView else { return }
            
            let location = gesture.location(in: sceneView)
            
            if gesture.state == .began {
                // Detect if the gesture location hits a piece or not
                let hits = sceneView.hitTest(location, options: nil)
                
                if let hit = hits.first(where: { $0.node.name!.prefix(5) == "piece" }) {
                    // If so, select the piece and set the last hit position
                    selectedNode = hit.node
                    lastHitPosition = hit.worldCoordinates
                }
            } else if gesture.state == .changed {
                // During the drag, update the selected node's position
                guard let node = selectedNode, let lastPos = lastHitPosition else { return }
                
                let hitResults = sceneView.hitTest(
                    location,
                    options: [SCNHitTestOption.boundingBoxOnly: true]
                )
                
                if let result = hitResults.first {
                    let newPos = result.worldCoordinates
                    node.position = SCNVector3(newPos.x, lastPos.y, newPos.z)
                }
            } else if gesture.state == .ended {
                guard let node = selectedNode else { return }

                // When the drag ends, check if the node is close to a plane object
                // If so, snap it to that plane's position
                if let scene = sceneView.scene {
                    var minDist: Float = 100000.0
                    var snapPosition: SCNVector3 = SCNVector3()
                    var planeTag: String = ""

                    // Find the plane object that is closest to the selected node
                    for potentialPlane in scene.rootNode.childNodes where potentialPlane.name!.prefix(5) == "plane" {
                        let distance = getDistance(pos1: node.worldPosition, pos2: potentialPlane.worldPosition)
                        
                        if distance < minDist {
                            minDist = distance
                            snapPosition = potentialPlane.worldPosition
                            planeTag = potentialPlane.name!
                        }
                    }

                    // If the closest plane is less than 1 unit in distance, set the node's position to the plane's position
                    if (minDist < 1.0) {
                        node.position = snapPosition
                        // Set the planeTag key to the plane's tag and the value to the node's tag
                        tagPairs[planeTag] = node.name
                        print(tagPairs)
                        print(tagPairs.count)
                        print(levelPieceCounts[sceneToDisplay]!)
                    }
                }

                selectedNode = nil
                lastHitPosition = nil

                // If the number of paired planes / pieces is equal to the total number of pieces,
                // then each piece is currently snapped to a position on the grid.
                // We can now check if the pieces are in the correct positions and whether the level is complete or not.
                if tagPairs.count >= levelPieceCounts[sceneToDisplay]! {
                    var correctPieces = 0

                    // If the last 2 characters of each key in the pairs dict matches the last 2 of their
                    // associated values, then each piece is paired with the correct grid position.
                    for pair in tagPairs {
                        if pair.key.suffix(2) == pair.value.suffix(2) {
                            correctPieces += 1
                        }
                    }

                    // If the number of correct pieces equals the total number of pieces, the player wins
                    if correctPieces == tagPairs.count {
                        level.playerWon = true
                        resetLevel()
                        print("===============")
                        print("PLAYER WINS, LEVEL IS FINISHED")
                    }
                }
            }
        }

        // Helper function for getting x/z distance between 2 objects
        func getDistance(pos1: SCNVector3, pos2: SCNVector3) -> Float {
            return sqrt(pow(pos2.x - pos1.x, 2) + pow(pos2.z - pos1.z, 2))
        }

        // Function to reset the level to the start state
        func resetLevel() {
            tagPairs = [:]
            selectedNode = nil
            lastHitPosition = nil
        }
    }
}

#Preview {
    GameView()
        .environmentObject(LevelViewModel())
}
