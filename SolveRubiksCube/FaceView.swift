// File: FaceView.swift
// Project: SolveRubiksCube
// Purpose: Displays a single cube face
// Created by Reese Barnett on 9/9/22.


import SwiftUI

/// A view that displays a single face of the cube.
struct FaceView: View {
    
    @ObservedObject var cube: Cube
    var face: FaceLocation
    var colors: [Color] {
        cube.faceColors(for: face)
    }
    
    // Gets the label based on the face
    var label: String {
        switch face {
        case .front:
            return "F"
        case .back:
            return "B"
        case .right:
            return "R"
        case .left:
            return "L"
        case .top:
            return "U"
        case .bottom:
            return "D"
        }
    }
    
    let cols: [GridItem] = Array(repeating: .init(.fixed(30)), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                LazyVGrid(columns: cols) {
                    
                    ForEach(0..<9) {
                        Rectangle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(colors[$0])
                            .overlay {
                                Rectangle()
                                    .stroke(.black, lineWidth: 2)
                            }
                        
                    }
                }
                .frame(width: 115, height: 115)
            }
            
            // Rotates the B label
            if label == "B" {
                Text(label)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .rotationEffect(.degrees(180))
            } else {
                Text(label)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
        }
    }
}

struct FaceView_Previews: PreviewProvider {
    static var previews: some View {
        FaceView(cube: Cube(), face: .front)
    }
}
