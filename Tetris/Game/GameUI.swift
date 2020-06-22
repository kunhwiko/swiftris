//
//  TetrisGameViewModel.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI
import Combine

struct Square {
    var color : Color
}

class GameUI: ObservableObject {
    @Published var tetrisGameModel = GameModel()
    var rows: Int {tetrisGameModel.rows}
    var cols: Int {tetrisGameModel.cols}
    var board: [[Square]] {
        var board = tetrisGameModel.grid.map {$0.map(convertToSquare)}
        
        if let tetromino = tetrisGameModel.tetromino {
            for blockLocation in tetromino.blocks {
                board[blockLocation.row + tetromino.origin.row][blockLocation.column + tetromino.origin.column]
                    = Square(color:getColor(blockType:tetromino.blockType))
            }
        }
        return board
    }
    
    var anyCancellable : AnyCancellable?
    
    init(){
        anyCancellable = tetrisGameModel.objectWillChange.sink {
            self.objectWillChange.send()
        }
    }

    func convertToSquare(block:Block?) -> Square {
        return Square(color: getColor(blockType: block?.blockType))
    }
    
    func getColor(blockType: String?) -> Color {
        switch blockType {
        case "I":
            return .customCyan
        case "O":
            return .yellow
        case "T":
            return .purple
        case "S":
            return .green
        case "Z":
            return .red
        case "J":
            return .blue
        case "L":
            return .orange
        default:
            return .black
        }
    }
}

