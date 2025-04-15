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
        Coordinator()
    }
    
    class Coordinator: NSObject {
        weak var sceneView: SCNView?
        var selectedNode: SCNNode?
        var lastHitPosition: SCNVector3?
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let sceneView = sceneView else { return }
            let location = gesture.location(in: sceneView)
            
            if gesture.state == .began {
                let hits = sceneView.hitTest(location, options: nil)
                
                if let hit = hits.first(where: { $0.node.name == "piece" }) {
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
                selectedNode = nil
                lastHitPosition = nil
            }
        }
    }
}
