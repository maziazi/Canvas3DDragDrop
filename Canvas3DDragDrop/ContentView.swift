//
//  ContentView.swift
//  Canvas3DDragDrop
//
//  Created by Muhamad Azis on 21/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CanvasView()
                .navigationTitle("Canvas 3D")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
