//
//  GamePieces.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

// Block is a single square of a tetris piece
struct Block {
    var blockType : String
    var color : Color
}

struct BlockPosition {
    var row:Int
    var column:Int
}

// TetrisPiece is an entire tetromino made of 4 blocks
struct TetrisPiece {
    var startPos: BlockPosition
    var blockType : String
    var color : Color {return TetrisPiece.getColors(blockType: blockType)}
    var blocks : [BlockPosition] {return TetrisPiece.getBlocks(blockType: blockType)}
    
    func move(row:Int, column:Int) -> TetrisPiece{
        let newPos = BlockPosition(row:startPos.row+row, column:startPos.column+column)
        return TetrisPiece(startPos:newPos, blockType: blockType)
    }
    
    // we make these functions 'functions of the struct' and not 'functions of an instance of struct'
    static func getRandomType() -> String{
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
    
    static func getColors(blockType: String) -> Color {
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
    
    static func getShadowColors(blockType: String) -> Color {
        switch blockType {
        case "I":
            return .customShadowCyan
        case "O":
            return .customShadowYellow
        case "T":
            return .customShadowPurple
        case "S":
            return .customShadowGreen
        case "Z":
            return .customShadowRed
        case "J":
            return .customShadowBlue
        case "L":
            return .customShadowOrange
        default:
            return .customBoardColor
        }
    }
    
    static func createNewPiece(row: Int, column: Int) -> TetrisPiece {
        let blockType = getRandomType()
        var origin:BlockPosition
        
        if blockType == "Z" {
            origin = BlockPosition(row: 1, column: (column-1)/2)
        } else {
            origin = BlockPosition(row: 0, column: (column-1)/2)
        }
        return TetrisPiece(startPos: origin, blockType: blockType)
    }
}

