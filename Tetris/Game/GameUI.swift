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
    @Published var model = GameModel()
    var rows: Int {model.rows}
    var cols: Int {model.cols}
    
    // this board is used to set colors on the tetris board 
    var board: [[Square]] {
        var board = model.grid.map {$0.map(convertToSquare)}
        
        if let tetromino = model.tetrisBlock {
            for blockLocation in tetromino.blocks {
                board[blockLocation.row + tetromino.startPos.row][blockLocation.column + tetromino.startPos.column]
                    = Square(color:getColor(blockType:tetromino.blockType))
            }
        }
        return board
    }
    
    // automatically notify for changes and update 
    var anyCancellable : AnyCancellable?
    init(){
        anyCancellable = model.objectWillChange.sink {
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
            return .customBoardColor
        }
    }
}

