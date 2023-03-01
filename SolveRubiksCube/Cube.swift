// File: Cube.swift
// Project: SolveRubiksCube
// Purpose:
// Created by Reese Barnett on 9/9/22.


import Foundation
import SwiftUI

/// Manages the operations and creation of a cube.
class Cube: ObservableObject {
    
    /// A three dimension matrix that represents the cube.
    @Published var cube: [Face]
    
    /// Fills the three dimenional matrix
    init() {
        cube = []
        fillCube()
    }
    
    /// Regroups all the colors to their respective faces.
    func reset() {
        cube.removeAll(keepingCapacity: true)
        fillCube()
    }
    
    /**
     Rotates a face.
     - Parameters:
        - face: The face being rotated.
        - direction: The direction to rotate (clockwise or counter-clockwise)
     */
    func rotate(_ face: FaceLocation, _ direction: Direction) {
        
        let temp = cube
        let delta = direction == .clockWise ? 0 : 2
        
        // Sets the other faces in relation to the current face
        let right = getFace(.right, of: face)
        let top = getFace(.top, of: face)
        let left = getFace(.left, of: face)
        let bottom = getFace(.bottom, of: face)
        
        // Gets the faces that share a border with the current face
        let rborder = direction == .clockWise ? top : bottom
        let tborder = direction == .clockWise ? left : right
        let lborder = direction == .clockWise ? bottom : top
        let bborder = direction == .clockWise ? right : left
        
        // Perfroms the rotation on the specified face
        switch face {
        case .front:
            for i in 0..<3 { // Iterates 3 times for the 3 connected cells shared by any two faces
                cube[right].cells[i][0].color = temp[rborder].cells[abs(delta-2)][abs(delta-i)].color
                cube[top].cells[2][i].color = temp[tborder].cells[abs(abs(delta-2)-i)][abs(delta-2)].color
                cube[left].cells[i][2].color = temp[lborder].cells[delta][abs(delta-i)].color
                cube[bottom].cells[0][i].color = temp[bborder].cells[abs(abs(delta-2)-i)][delta].color
            }
        case .back:
            for i in 0..<3 {
                cube[right].cells[i][0].color = temp[rborder].cells[abs(delta)][abs(abs(delta-2)-i)].color
                cube[top].cells[0][i].color = temp[tborder].cells[abs(delta-i)][abs(delta-2)].color
                cube[left].cells[i][2].color = temp[lborder].cells[abs(delta-2)][abs(abs(delta-2)-i)].color
                cube[bottom].cells[2][i].color = temp[bborder].cells[abs(delta-i)][delta].color
            }
        case .right:
            for i in 0..<3 {
                cube[right].cells[i][2].color = temp[rborder].cells[i][2].color
                cube[top].cells[i][2].color = temp[tborder].cells[i][2].color
                cube[left].cells[i][2].color = temp[lborder].cells[i][2].color
                cube[bottom].cells[i][2].color = temp[bborder].cells[i][2].color
            }
        case .left:
            for i in 0..<3 {
                cube[right].cells[i][0].color = temp[rborder].cells[i][0].color
                cube[top].cells[i][0].color = temp[tborder].cells[i][0].color
                cube[left].cells[i][0].color = temp[lborder].cells[i][0].color
                cube[bottom].cells[i][0].color = temp[bborder].cells[i][0].color
            }
        case .top:
            for i in 0..<3 {
                cube[right].cells[0][i].color = temp[rborder].cells[abs(delta-2)][abs(abs(delta-2)-i)].color
                cube[top].cells[2][i].color = temp[tborder].cells[0][2-i].color
                cube[left].cells[0][i].color = temp[lborder].cells[delta][abs(delta-i)].color
                cube[bottom].cells[0][i].color = temp[bborder].cells[0][i].color
            }
        case .bottom:
            for i in 0..<3 {
                cube[right].cells[2][i].color = temp[rborder].cells[abs(delta-2)][abs(delta-i)].color
                cube[top].cells[2][i].color = temp[tborder].cells[2][i].color
                cube[left].cells[2][i].color = temp[lborder].cells[delta][abs(abs(delta-2)-i)].color
                cube[bottom].cells[0][i].color = temp[bborder].cells[2][2-i].color
            }
        }

        for i in 0..<3 {
            cube[face.rawValue].cells[0][i].color = temp[face.rawValue].cells[abs(abs(delta-2)-i)][delta-0].color
            cube[face.rawValue].cells[i][2].color = temp[face.rawValue].cells[delta-0][abs(delta-i)].color
            cube[face.rawValue].cells[2][i].color = temp[face.rawValue].cells[abs(abs(delta-2)-i)][abs(delta-2)].color
            cube[face.rawValue].cells[i][0].color = temp[face.rawValue].cells[abs(delta-2)][abs(delta-i)].color
        }
    }
    
    /**
     Gets the index of a face relative to the specified face.
     - Parameters:
        - direction: The direction of the face you want with respect to the specified face.
        - face: The face the direction is relative to.
     - Returns: The index of the new face.
     */
    private func getFace(_ direction: FaceLocation, of face: FaceLocation) -> Int {
        
        var theFace: FaceLocation
        
        switch face {
        case .front:
            theFace = direction
        case .back:
            switch direction {
            case .front:
                theFace = .back
            case .back:
                theFace = .front
            case .right:
                theFace = .left
            case .left:
                theFace = .right
            case .top:
                theFace = .top
            case .bottom:
                theFace = .bottom
            }
        case .right:
            switch direction {
            case .front:
                theFace = .right
            case .back:
                theFace = .left
            case .right:
                theFace = .back
            case .left:
                theFace = .front
            case .top:
                theFace = .top
            case .bottom:
                theFace = .bottom
            }
        case .left:
            switch direction {
            case .front:
                theFace = .left
            case .back:
                theFace = .right
            case .right:
                theFace = .front
            case .left:
                theFace = .back
            case .top:
                theFace = .top
            case .bottom:
                theFace = .bottom
            }
        case .top:
            switch direction {
            case .front:
                theFace = .top
            case .back:
                theFace = .bottom
            case .right:
                theFace = .right
            case .left:
                theFace = .left
            case .top:
                theFace = .back
            case .bottom:
                theFace = .front
            }
        case .bottom:
            switch direction {
            case .front:
                theFace = .bottom
            case .back:
                theFace = .top
            case .right:
                theFace = .right
            case .left:
                theFace = .left
            case .top:
                theFace = .front
            case .bottom:
                theFace = .back
            }
        }
        return theFace.rawValue
    }
    
    /**
     Gets the nine colors from a face.
     - Parameter face: The face the colors are coming from
     - Returns: A list of colors.
     - Note: The list is organized like [r1c1, r1c2, ... , r3c2, r3c3]. (r-row, c-column)
     */
   func faceColors(for face: FaceLocation) -> [Color] {
        
       let face = cube[face.rawValue].cells
       var colors: [Color] = []
       
       for r in 0...2 {
           for c in 0...2 {
               colors.append(getColor(for: face[r][c].color))
           }
       }
       return colors
    }
    
    /**
     Converts `CellColor` to `Color`.
     - Parameter color: The cell color that is being converted.
     - Returns: The `Color` representation.
     */
    private func getColor(for color: CellColor) -> Color {
        
        var uiColor: Color
        
        switch color {
        case .red:
            uiColor = .red
        case .white:
            uiColor = .white
        case .blue:
            uiColor = .blue
        case .yellow:
            uiColor = .yellow
        case .orange:
            uiColor = .orange
        case .green:
            uiColor = .green
        }
        
        return uiColor
    }
    
    /// Fills the rubiks cube
    private func fillCube() {
        let colors: [CellColor] = [.white, .yellow, .red, .orange, .blue, .green]
        var face: Face
        
        for i in 0..<6 {
            face = Face()
            for row in 0...2 {
                for _ in 0...2 {
                    face.cells[row].append(Cell(color: colors[i]))
                }
            }
            cube.append(face)
        }
    }
}
