// File: Models.swift
// Project: SolveRubiksCube
// Purpose: Defines various profiles and objects.
// Created by Reese Barnett on 9/9/22.


import Foundation

/// A profile that represents the colors a cell can be.
enum CellColor: Int, CaseIterable {
    case red = 0, white, blue, yellow, orange, green
}

/// A profile that represents the location of a face.
enum FaceLocation: Int {
    case front = 0, back, right, left, top, bottom
}

/// A profile that represents the direction a face can rotate.
enum Direction {
    case clockWise, counterClockWise
}

/// A single square on a face.
struct Cell {
    
    /// The color of the cell.
    var color: CellColor
}

/// A single face on the cube.
struct Face {
    
    /// The matrix that represents the face.
    var cells: [[Cell]]
    
    /// Creates an empty matrix.
    init() {
        cells = [[],[],[]]
    }
}

