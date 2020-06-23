//
//  GameUI.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

// Use observableobject to notify to viewer that changes must be made
class GameUI : ObservableObject {
    var rows: Int
    var cols: Int
    
    // "grid" is a 20x10 tetris board that will fill with blocks
    // Use published to get the latest updated value
    // TetrisPiece might be nil, so we use optionals
    @Published var grid: [[Block]]
    @Published var piece: TetrisPiece?
    var shadow : TetrisPiece? {
        guard var floorShadow = piece else { return nil }
        var testShadow = floorShadow
        while isValid(test: testShadow) {
            floorShadow = testShadow
            testShadow = floorShadow.move(row: 1, column: 0)
        }
        return floorShadow
    }
    
    var board: [[Block]] {
        var board = grid
        
        if let shadow = self.shadow {
            for blockPos in shadow.blocks {
                board[blockPos.row + shadow.startPos.row][blockPos.column + shadow.startPos.column]
                    = Block(blockType:shadow.blockType, color:TetrisPiece.getShadowColors(blockType: shadow.blockType))
            }
        }
        
        if piece != nil {
            for blockPos in piece!.blocks {
                board[blockPos.row + piece!.startPos.row][blockPos.column + piece!.startPos.column]
                    = Block(blockType:piece!.blockType, color:piece!.color)
            }
        }
        
        return board
    }
    
    var timer : Timer?
    var prevPos : CGPoint?
    
    init(rows: Int = 20, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        
        grid = Array(repeating: Array(repeating: Block(blockType: "X", color: Color.customBoardColor), count: cols), count:rows)
        piece = TetrisPiece.createNewPiece(row: 0, column: cols)
        startGame()
    }
    
    
    func startGame() {
        // execute runGame when timer fires
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: runGame)
    }
    
    
    func runGame(timer: Timer){
        if clearLine() { return }
        
        if piece == nil {
            piece = TetrisPiece.createNewPiece(row: 0, column: cols)
            if isValid(test:piece!) == false {
                timer.invalidate()
            }
            return
        }
        
        if movePieceDown() {
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
        // guard statements allows us to set currPiece = piece unless piece is nil
        // if piece is nil, run the else statement
        guard let currPiece = piece else {return}
        
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
    
    
    func movePiece(rowOffset:Int, colOffset:Int) -> Bool{
        // logic without guard statement
        var currPiece : TetrisPiece
        if piece != nil {
            currPiece = piece!
        } else {
            return false
        }
        
        let movePiece = currPiece.move(row: rowOffset, column: colOffset)
        if isValid(test: movePiece) {
            piece = movePiece
            return true
        }
        return false
    }
    
    
    func getMouseGesture() -> some Gesture {
        return DragGesture()
        .onChanged(onMouseGesture(value:))
        .onEnded(onMouseEnded(_:))
    }
    
    
    func onMouseGesture(value: DragGesture.Value) {
        guard let start = prevPos else {
            prevPos = value.location
            return
        }
        
        let xOffset = value.location.x - start.x
        let yOffset = value.location.y - start.y
        
        if xOffset < -10 {
            let _  = movePieceLeft()
            prevPos = value.location
            return
        }
        if xOffset > 10 {
            let _  = movePieceRight()
            prevPos = value.location
            return
        }
        if yOffset < -10 {
            hardDrop()
            prevPos = value.location
            return
        }
        if yOffset > 10 {
            let _ = movePieceDown()
            prevPos = value.location
            return
        }
    }
    
    
    func onMouseEnded(_: DragGesture.Value) {
        prevPos = nil
    }
    
    func movePieceDown() -> Bool {
        return movePiece(rowOffset:1, colOffset:0)
    }
    
    func movePieceLeft() -> Bool {
        return movePiece(rowOffset:0, colOffset:-1)
    }
    
    func movePieceRight() -> Bool {
        return movePiece(rowOffset:0, colOffset:1)
    }
    
    func hardDrop() {
        while movePieceDown() {}
    }
    
    
    // Copy a new grid that will remove any filled up rows
    func clearLine() -> Bool {
        var newGrid = Array(repeating: Array(repeating: Block(blockType: "X", color: Color.customBoardColor), count: cols), count:rows)
        var lineWasCleared = false
        var rowToCopy = 19
        
        for row in 0...rows-1 {
            var clearLine = true
            for col in 0...cols-1 {
                if grid[19-row][col].blockType == "X" {clearLine = false}
            }
            
            if clearLine == false {
                for col in 0...cols-1 {
                    newGrid[rowToCopy][col] = grid[19-row][col]
                }
                rowToCopy -= 1
            }
            
            if clearLine == true {
                lineWasCleared = true
            }
        }
        
        if lineWasCleared {
            grid = newGrid
        }
        return lineWasCleared
    }
}







