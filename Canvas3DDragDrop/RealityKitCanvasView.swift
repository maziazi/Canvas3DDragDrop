//
//  RealityKitCanvasView.swift
//  Canvas3DDragDrop
//
//  Created by Muhamad Azis on 21/06/25.
//

import SwiftUI
import RealityKit

struct RealityKitCanvasView: UIViewRepresentable {
    @Binding var placedObjects: [Entity]
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.enableGestures()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        for object in placedObjects {
            if !uiView.scene.anchors.contains(where: { $0.name == object.name }) {
                let anchor = AnchorEntity(world: .zero)
                anchor.addChild(object)
                uiView.scene.addAnchor(anchor)
            }
        }
    }
}

func makeUIView(context: ARView) -> ARView {
    let arView = ARView(frame: .zero)
    arView.enableGestures() // Aktifkan semua gestur
    return arView
}
    
extension ARView {
    func enableGestures() {
        enableDragGesture()
        enableRotationGesture()
        enablePinchGesture()
    }
    
    func enableDragGesture() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func enableRotationGesture() {
        let gestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func enablePinchGesture() {
        let gestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleDrag(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) as? ModelEntity {
            let translation = gesture.translation(in: self)
            entity.position.x += Float(translation.x) * 0.01
            entity.position.y -= Float(translation.y) * 0.01
            gesture.setTranslation(.zero, in: self)
        }
    }
    
    @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) as? ModelEntity {
            let rotation = gesture.rotation
            entity.transform.rotation *= simd_quatf(angle: Float(rotation), axis: [0, 1, 0])
            gesture.rotation = 0
        }
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        let location = gesture.location(in: self)
        
        if let entity = self.entity(at: location) as? ModelEntity {
            let scale = gesture.scale
            entity.transform.scale *= Float(scale)
            gesture.scale = 1
        }
    }
    
    func enableLongPressGesture() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let location = gesture.location(in: self)
            
            if let entity = self.entity(at: location) {
                entity.removeFromParent()
            }
        }
    }
}

