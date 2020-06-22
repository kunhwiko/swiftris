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

struct BlockPosition {
    var row:Int
    var column:Int
}

struct TetrisPieces {
    var startPos: BlockPosition
    var blockType : String
    var blocks : [BlockPosition] {return TetrisPieces.getBlocks(blockType: blockType)}
    
    func move(row:Int, column:Int) -> TetrisPieces{
        let newPos = BlockPosition(row:startPos.row+row, column:startPos.column+column)
        return TetrisPieces(startPos:newPos, blockType: blockType)
    }
    
    static func getRandomBlock() -> String{
        let type = ["I","O","T","S","Z","J","L"]
        return type.randomElement()!
    }
    
    static func getBlocks(blockType: String) -> [BlockPosition] {
        switch blockType {
        case "I":
            return
                [
                    BlockPosition(row:0, column:-1),BlockPosition(row:0, column:0),
                    BlockPosition(row:0, column:1), BlockPosition(row:0, column:2)
                ]
        case "O":
            return
                [
                    BlockPosition(row:0, column:0),BlockPosition(row:0, column:1),
                    BlockPosition(row:1, column:1), BlockPosition(row:1, column:0)
                ]
        case "T":
            return
                [
                    BlockPosition(row:0, column:-1),BlockPosition(row:0, column:0),
                    BlockPosition(row:0, column:1), BlockPosition(row:1, column:0)
                ]
        case "S":
            return
                [
                    BlockPosition(row:0, column:-1),BlockPosition(row:0, column:0),
                    BlockPosition(row:1, column:0), BlockPosition(row:1, column:1)
                ]
        case "Z":
            return
                [
                    BlockPosition(row:-1, column:0),BlockPosition(row:0, column:0),
                    BlockPosition(row:0, column:-1), BlockPosition(row:-1, column:1)
                ]
        case "J":
            return
                [
                    BlockPosition(row:1, column:-1),BlockPosition(row:0, column:-1),
                    BlockPosition(row:0, column:0), BlockPosition(row:0, column:1)
                ]
        case "L":
            return
                [
                    BlockPosition(row:0, column:-1),BlockPosition(row:0, column:0),
                    BlockPosition(row:0, column:1), BlockPosition(row:1, column:1)
                ]
        default:
            return
                [
                    BlockPosition(row:0, column:0),BlockPosition(row:0, column:0),
                    BlockPosition(row:0, column:0), BlockPosition(row:0, column:0)
                ]
        }
    }
    
    static func createNewPiece(row: Int, column: Int) -> TetrisPieces {
        let blockType = getRandomBlock()
        var origin:BlockPosition
        
        if blockType == "Z" {
            origin = BlockPosition(row: 1, column: (column-1)/2)
        } else {
            origin = BlockPosition(row: 0, column: (column-1)/2)
        }
        return TetrisPieces(startPos: origin, blockType: blockType)
    }
}
