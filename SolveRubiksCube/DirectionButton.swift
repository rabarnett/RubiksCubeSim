// File: DirectionButton.swift
// Project: SolveRubiksCube
// Purpose: Display a pair of rotation buttons.
// Created by Reese Barnett on 3/1/23.

import SwiftUI

/// A view that displays a pair of rotation buttons.
struct DirectionButton: View {
    
    @ObservedObject var cube: Cube
    var label: String
    var faces: [String:FaceLocation] = ["F":.front, "U":.top, "R":.right, "D":.bottom, "B":.back, "L":.left]
    
    var body: some View {
        VStack(spacing: 20) {
            Button(label) {
                cube.rotate(faces[label]!, .clockWise)
            }
            
            Button("\(label)'") {
                cube.rotate(faces[label]!, .counterClockWise)
            }
        }
    }
}

struct DirectionButton_Previews: PreviewProvider {
    static var previews: some View {
        DirectionButton(cube: Cube(), label: "F")
    }
}
