//
//  CanvasView.swift
//  Canvas3DDragDrop
//
//  Created by Muhamad Azis on 21/06/25.
//

import SwiftUI
import RealityKit

struct CanvasView: View {
    @State private var placedObjects: [Entity] = []
    
    var body: some View {
        ZStack {
            RealityKitCanvasView(placedObjects: $placedObjects)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    ObjectButton(icon: "chair.fill", objectName: "Kursi") {
                        addObject(named: "Kursi")
                    }
                    ObjectButton(icon: "table.fill", objectName: "Meja") {
                        addObject(named: "Vanesh")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding()
            }
        }
    }
    
    func addObject(named name: String) {
        if let model = try? ModelEntity.load(named: name) {
            model.generateCollisionShapes(recursive: true)
            model.name = name
            placedObjects.append(model)
        }
    }
}

struct ObjectButton: View {
    let icon: String
    let objectName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.title)
                    .padding(10)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                Text(objectName)
                    .font(.caption)
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}
