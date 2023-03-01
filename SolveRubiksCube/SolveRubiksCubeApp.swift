// File: SolveRubiksCubeApp.swift
// Project: SolveRubiksCube
// Purpose: Initialize the rubiks cube.
// Created by Reese Barnett on 9/9/22.


import SwiftUI

@main
struct SolveRubiksCubeApp: App {
    
    @ObservedObject var cube = Cube()
    
    var body: some Scene {
        WindowGroup {
            ContentView(cube: cube)
        }
    }
}
