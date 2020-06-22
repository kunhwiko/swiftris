//
//  GamePieces.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct Block {
    var blockType : String 
}


struct BlockLocation {
    var row:Int
    var column:Int
}


struct TetrisPieces {
    var origin : BlockLocation
    var blockType : String
    var blocks : [BlockLocation] {
        return TetrisPieces.getBlocks(blockType: blockType)
    }
    
    func moveBy(row:Int, column:Int) -> TetrisPieces{
        let newOrigin = BlockLocation(row:origin.row+row, column:origin.column+column)
        return TetrisPieces(origin:newOrigin, blockType: blockType)
    }
    
    static func getRandomBlock() -> String{
        let type = ["I","O","T","S","Z","J","L"]
        return type.randomElement()!
    }
    
    static func getBlocks(blockType: String) -> [BlockLocation] {
        switch blockType {
        case "I":
            return
                [
                    BlockLocation(row:0, column:-1),BlockLocation(row:0, column:0),
                    BlockLocation(row:0, column:1), BlockLocation(row:0, column:2)
                ]
        case "O":
            return
                [
                    BlockLocation(row:0, column:0),BlockLocation(row:0, column:1),
                    BlockLocation(row:1, column:1), BlockLocation(row:1, column:0)
                ]
        case "T":
            return
                [
                    BlockLocation(row:0, column:-1),BlockLocation(row:0, column:0),
                    BlockLocation(row:0, column:1), BlockLocation(row:1, column:0)
                ]
        case "S":
            return
                [
                    BlockLocation(row:0, column:-1),BlockLocation(row:0, column:0),
                    BlockLocation(row:1, column:0), BlockLocation(row:1, column:1)
                ]
        case "Z":
            return
                [
                    BlockLocation(row:-1, column:0),BlockLocation(row:0, column:0),
                    BlockLocation(row:0, column:-1), BlockLocation(row:-1, column:1)
                ]
        case "J":
            return
                [
                    BlockLocation(row:1, column:-1),BlockLocation(row:0, column:-1),
                    BlockLocation(row:0, column:0), BlockLocation(row:0, column:1)
                ]
        case "L":
            return
                [
                    BlockLocation(row:0, column:-1),BlockLocation(row:0, column:0),
                    BlockLocation(row:0, column:1), BlockLocation(row:1, column:1)
                ]
        default:
            return
                [
                    BlockLocation(row:0, column:0),BlockLocation(row:0, column:0),
                    BlockLocation(row:0, column:0), BlockLocation(row:0, column:0)
                ]
        }
    }
    
    static func createNewTetromino(numRows: Int, numColumns: Int) -> TetrisPieces {
        let blockType = getRandomBlock()
        
        var maxRow = 0
        for block in getBlocks(blockType: blockType) {
            maxRow = max(maxRow, block.row)
        }
        
        let origin = BlockLocation(row: numRows - 1 - maxRow, column: (numColumns-1)/2)
        return TetrisPieces(origin: origin, blockType: blockType)
    }
}
