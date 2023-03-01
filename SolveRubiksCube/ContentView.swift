// File: ContentView.swift
// Project: SolveRubiksCube
// Purpose: Displays the cube and rotation buttons.
// Created by Reese Barnett on 9/9/22.


import SwiftUI

/// A view that displays the cube and rotation buttons.
struct ContentView: View {
    
    @ObservedObject var cube: Cube
    var face: [FaceLocation] = [.front, .back, .right, .left, .top, .bottom]
    var directions = ["F", "U", "L", "R", "D", "B"]
    
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            
            VStack {
                FaceView(cube: cube, face: .back)
                FaceView(cube: cube, face: .top)
                HStack {
                    FaceView(cube: cube, face: .left)
                    FaceView(cube: cube, face: .front)
                    FaceView(cube: cube, face: .right)
                }
                
                FaceView(cube: cube, face: .bottom)
                
                // Displays the rotation buttons
                HStack {
                    ForEach(directions, id: \.self) { dir in
                        DirectionButton(cube: cube, label: dir)
                    }
                }
                .padding()
                
                Button("Reset") {
                    cube.reset()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cube: Cube())
    }
}
