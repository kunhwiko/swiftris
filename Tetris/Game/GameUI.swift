//
//  GameUI.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

// Use observableobject to notify to viewer that changes must be made 
class GameModel : ObservableObject {
    var rows: Int
    var cols: Int
    
    var timer : Timer?
    
    // grid is a 20x10 tetris board that will fill with nil or blocks 
    // Use published to get the latest updated value
    // TetrisPiece might be nil, so we use optionals
    @Published var grid: [[Block]]
    @Published var piece: TetrisPiece?
    var board: [[Square]] {
        var board = grid.map {$0.map(convertToSquare)}
        
        if let tetromino = piece {
            for blockLocation in tetromino.blocks {
                board[blockLocation.row + tetromino.startPos.row][blockLocation.column + tetromino.startPos.column]
                    = Square(color:getColor(blockType:tetromino.blockType))
            }
        }
        return board
    }
    
    init(rows: Int = 20, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        
        grid = Array(repeating: Array(repeating: Block(blockType: "X", color: Color.customBoardColor), count: cols), count:rows)
        piece = TetrisPiece.createNewPiece(row: 0, column: cols)
        startGame()
    }
    
    func startGame() {
        // execute runGame when timer fires
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: runGame)
    }
    
    func runGame(timer: Timer){
        // guard statements allows us to set currPiece = piece unless piece is nil
        // if piece is nil, run the else statement and end the program
        guard let currPiece = piece else{
            piece = TetrisPiece.createNewPiece(row: 0, column: cols)
            if isValid(test:piece!) == false {
                timer.invalidate()
            }
            return
        }
        
        let movePiece = currPiece.move(row: 1, column: 0)
        if isValid(test: movePiece) {
            piece = movePiece
            return
        }
        isPlaced()
    }
    
    func isValid(test: TetrisPiece) -> Bool {
        for block in test.blocks {
            let row = test.startPos.row + block.row
            let column = test.startPos.column + block.column
            if row < 0 || row >= rows || column < 0 || column >= cols {return false}
            if grid[row][column].blockType != "X" {return false}
        }
        return true
    }
    
    func isPlaced() {
        // example without using guard statement
        var currPiece : TetrisPiece
        if piece != nil {
            currPiece = piece!
        } else {
            return
        }

        for block in currPiece.blocks {
            let row = currPiece.startPos.row + block.row
            let column = currPiece.startPos.column + block.column
            if row < 0 || row >= rows || column < 0 || column >= cols {
                continue
            }
            grid[row][column] = Block(blockType : currPiece.blockType, color: currPiece.color)
        }
        piece = nil
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
    
    struct Square {
        var color : Color
    }
}






