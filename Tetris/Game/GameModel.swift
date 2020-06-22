//
//  TetrisGameModel.swift
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
    
    // this grid is used to set blocks on the tetris board 
    @Published var grid: [[Block?]] // Use published to get the latest updated value 
    @Published var tetrisBlock: TetrisPieces?
    
    // Initialize the board as 20x10 of "Square"s
    init(rows: Int = 20, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        
        grid = Array(repeating: Array(repeating: nil, count: cols), count:rows)
        tetrisBlock = TetrisPieces.createNewPiece(row: 0, column: cols)
        startGame()
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: runGame)
    }
    
    func runGame(timer: Timer){
        // guard allows us to set currPiece to tetrisBlock unless tetrisBlock is nil
        // if tetrisBlock is nil, end the program
        guard let currPiece = tetrisBlock else{
            tetrisBlock = TetrisPieces.createNewPiece(row: 0, column: cols)
            if isValid(test:tetrisBlock!) == false {
                timer.invalidate()
            }
            return
        }
        
        let movePiece = currPiece.move(row: 1, column: 0)
        if isValid(test: movePiece) {
            tetrisBlock = movePiece
            return
        }
        isPlaced()
    }
    
    func isValid(test: TetrisPieces) -> Bool {
        for block in test.blocks {
            let row = test.startPos.row + block.row
            let column = test.startPos.column + block.column
            if row < 0 || row >= rows || column < 0 || column >= cols || grid[row][column] != nil {
                return false
            }
        }
        return true
    }
    
    func isPlaced() {
        // without using guard statement 
        var currPiece : TetrisPieces
        if tetrisBlock != nil {
            currPiece = tetrisBlock!
        } else {
            return
        }

        for block in currPiece.blocks {
            let row = currPiece.startPos.row + block.row
            let column = currPiece.startPos.column + block.column
            if row < 0 || row >= rows || column < 0 || column >= cols {
                continue
            }
            grid[row][column] = Block(blockType : currPiece.blockType)
        }
        tetrisBlock = nil
    }
}






