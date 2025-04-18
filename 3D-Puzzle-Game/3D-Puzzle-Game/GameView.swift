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
    
    var body: some View {
        SceneViewWrapper()
    }
}

struct SceneViewWrapper: UIViewRepresentable {
    @EnvironmentObject var level: LevelViewModel
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene(named: level.sceneToDisplay)
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling4X
        sceneView.preferredFramesPerSecond = 60
        
        let panGesture = UIPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handlePan(_:))
        )
        
        sceneView.addGestureRecognizer(panGesture)
        context.coordinator.sceneView = sceneView
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(sceneToDisplay: level.sceneToDisplay)
    }
    
    class Coordinator: NSObject {
        weak var sceneView: SCNView?
        var selectedNode: SCNNode?
        var lastHitPosition: SCNVector3?
        var tagPairs: [String : String] = [:]
        var sceneToDisplay: String
        
        let levelPieceCounts: [String : Int] = [
            "art.scnassets/level1.scn" : 4,
            "art.scnassets/level2.scn" : 4
        ]
        
        init(sceneToDisplay: String) {
            self.sceneToDisplay = sceneToDisplay
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sceneView = sceneView else { return }
            
            let location = gesture.location(in: sceneView)
            
            if gesture.state == .began {
                let hits = sceneView.hitTest(location, options: nil)
                
                if let hit = hits.first(where: { $0.node.name!.prefix(5) == "piece" }) {
                    selectedNode = hit.node
                    lastHitPosition = hit.worldCoordinates
                }
            } else if gesture.state == .changed {
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

                if let scene = sceneView.scene {
                    var minDist: Float = 100000.0
                    var snapPosition: SCNVector3 = SCNVector3()
                    var planeTag: String = ""
                    
                    for potentialPlane in scene.rootNode.childNodes where potentialPlane.name!.prefix(5) == "plane" {
                        let distance = getDistance(pos1: node.worldPosition, pos2: potentialPlane.worldPosition)
                        
                        if distance < minDist { // adjust threshold as needed
                            minDist = distance
                            snapPosition = potentialPlane.worldPosition
                            planeTag = potentialPlane.name!
                        }
                    }
                    
                    if (minDist < 1.0) {
                        node.position = snapPosition
                        tagPairs[planeTag] = node.name
                        print(tagPairs)
                        print(tagPairs.count)
                        print(levelPieceCounts[sceneToDisplay]!)
                    }
                }

                selectedNode = nil
                lastHitPosition = nil
                
                if tagPairs.count >= levelPieceCounts[sceneToDisplay]! {
                    var correctPieces = 0
                    
                    for pair in tagPairs {
                        if pair.key.suffix(2) == pair.value.suffix(2) {
                            correctPieces += 1
                        }
                    }
                    
                    if correctPieces == tagPairs.count {
                        print("===============")
                        print("PLAYER WINS, LEVEL IS FINISHED")
                    }
                }
            }
        }
        
        func getDistance(pos1: SCNVector3, pos2: SCNVector3) -> Float {
            return sqrt(pow(pos2.x - pos1.x, 2) + pow(pos2.z - pos1.z, 2))
        }
    }
}
