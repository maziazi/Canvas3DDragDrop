//
//  CanvasView.swift
//  Canvas3DDragDrop
//
//  Created by Muhamad Azis on 23/06/25.
//

import SwiftUI
import RealityKit

struct CanvasView: View {
    @State private var placedObjects: [Entity] = []
    @State private var showingExportSheet = false
    
    var body: some View {
        ZStack {
            RealityKitCanvasView(placedObjects: $placedObjects)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Export button
                HStack {
                    Spacer()
                    Button("Export USDZ") {
                        exportToUSDZ()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    ObjectButton(icon: "chair.fill", objectName: "Kursi") {
                        addObject(named: "Kursi")
                    }
                    ObjectButton(icon: "table.fill", objectName: "KursiKotak") {
                        addObject(named: "KursiKotak")
                    }
                    ObjectButton(icon: "cube.fill", objectName: "Vanesh") {
                        addObject(named: "Vanesh")
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding()
            }
        }
        .sheet(isPresented: $showingExportSheet) {
            USDAExportView(objects: placedObjects)
        }
    }
    
    func addObject(named name: String) {
        // Try loading from bundle first, fallback to procedural generation
        if let model = try? ModelEntity.load(named: name) {
            model.generateCollisionShapes(recursive: true)
            model.name = name
            placedObjects.append(model)
        } else {
            // Fallback to procedural generation
            let entity = ObjectFactory.createProceduralModel(named: name)
            entity.name = name
            entity.generateCollisionShapes(recursive: true)
            placedObjects.append(entity)
        }
    }
    
    private func exportToUSDZ() {
        showingExportSheet = true
    }
}

#Preview {
    CanvasView()
}
