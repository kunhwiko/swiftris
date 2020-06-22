//
//  TetrisGameModel.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

class GameModel : ObservableObject {
    var rows: Int
    var cols: Int
    
    var timer : Timer?
    var speed : Double
    
    @Published var grid: [[Block?]]
    @Published var tetrisBlock: TetrisPieces?
    
    // Initialize the board as 20x10 of "Square"s
    init(rows: Int = 20, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        
        grid = Array(repeating: Array(repeating: nil, count: cols), count:rows)
        tetrisBlock = TetrisPieces(startPos: BlockPosition(row:0, column:4),blockType: "I")
        speed = 0.1
        resumeGame()
    }
    
    func resumeGame() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: runEngine)
    }
    
    func runEngine(timer: Timer){
        guard let currentTetromino = tetrisBlock else{
            tetrisBlock = TetrisPieces.createNewPiece(row: 0, column: cols)
            if !isValidTetromino(testTetromino:tetrisBlock!){
                timer.invalidate()
            }
            return
        }
        
        let newTetromino = currentTetromino.move(row: 1, column: 0)
        if isValidTetromino(testTetromino: newTetromino) {
            tetrisBlock = newTetromino
            return
        }
        placeTetromino()
    }
    
    func isValidTetromino(testTetromino: TetrisPieces) -> Bool {
        for block in testTetromino.blocks {
            let row = testTetromino.startPos.row + block.row
            if row < 0 || row >= rows { return false }
            
            let column = testTetromino.startPos.column + block.column
            if column < 0 || column >= cols { return false }
            
            if grid[row][column] != nil { return false }
        }
        return true
    }
    
    func placeTetromino() {
        guard let currentTetromino = tetrisBlock else {
            return
        }
        
        for block in currentTetromino.blocks {
            let row = currentTetromino.startPos.row + block.row
            if row < 0 || row >= rows { continue }
            
            let column = currentTetromino.startPos.column + block.column
            if column < 0 || column >= cols { continue }
            
            grid[row][column] = Block(blockType: currentTetromino.blockType)
        }
        
        tetrisBlock = nil
    }
}






