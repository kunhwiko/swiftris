//
//  GamePieces.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

// Block is a single square that makes up a tetris piece
struct Block {
    var blockType : String
    var color : Color
}

struct BlockPosition {
    var row:Int
    var column:Int
}

// TetrisPiece is an entire tetromino made up of 4 blocks
struct TetrisPiece {
    var startPos: BlockPosition
    var blockType : String
    var color : Color {return TetrisPiece.getColors(blockType: self.blockType)}
    var blocks : [BlockPosition] {return TetrisPiece.getBlocks(blockType: self.blockType, rotation: self.rotation)}
    var rotation : Int
    
    func move(row:Int, column:Int) -> TetrisPiece{
        let newPos = BlockPosition(row:startPos.row+row, column:startPos.column+column)
        return TetrisPiece(startPos:newPos, blockType: blockType, rotation: rotation)
    }
    
    func rotate(clockwise: Bool) -> TetrisPiece{
        return TetrisPiece(startPos: startPos, blockType: blockType, rotation: rotation + (clockwise ? -1: 1))
    }
    
    func kick(clockwise: Bool) -> [BlockPosition]{
        return TetrisPiece.getKicks(blockType: blockType, rotation: rotation, clockwise: clockwise)
    }
    
    // we make the following functions 'functions of the struct' and not 'functions of an instance of struct'
    static func getRandomType() -> String{
        let type = ["I","O","T","S","Z","J","L"]
        return type.randomElement()!
    }
    
    static func getBlocks(blockType: String, rotation: Int = 0) -> [BlockPosition] {
        let allBlocks = getAllBlocks(blockType: blockType)
        var index = rotation % allBlocks.count
        if index < 0 {index += allBlocks.count}
        return allBlocks[index]
    }
    
    // these are the block positions in all their rotated forms
    static func getAllBlocks(blockType: String) -> [[BlockPosition]] {
        switch blockType {
        case "I":
            return [[BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: 0, column: 2)],
                    [BlockPosition(row: -1, column: 1), BlockPosition(row: 0, column: 1),
                     BlockPosition(row: 1, column: 1),  BlockPosition(row: -2, column: 1)],
                    [BlockPosition(row: -1, column: -1),BlockPosition(row: -1, column: 0),
                     BlockPosition(row: -1, column: 1), BlockPosition(row: -1, column: 2)],
                    [BlockPosition(row: -1, column: 0), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 1, column: 0),  BlockPosition(row: -2, column: 0)]]
        case "O":
            return [[BlockPosition(row: 0, column: 0), BlockPosition(row: 0, column: 1),
                     BlockPosition(row: 1, column: 1), BlockPosition(row: 1, column: 0)]]
        case "T":
            return [[BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: 1, column: 0)],
                    [BlockPosition(row: -1, column: 0), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: 1, column: 0)],
                    [BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: -1, column: 0)],
                    [BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 1, column: 0),  BlockPosition(row: -1, column: 0)]]
        case "S":
            return [[BlockPosition(row: 1, column: -1), BlockPosition(row: 1, column: 0),
                     BlockPosition(row: 0, column: 0),  BlockPosition(row: 0, column: 1)],
                    [BlockPosition(row: 1, column: 1),  BlockPosition(row: 0, column: 1),
                     BlockPosition(row: 0, column: 0),  BlockPosition(row: -1, column: 0)],
                    [BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: -1, column: 1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: -1), BlockPosition(row: -1, column: -1)]]
        case "Z":
            return [[BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 1, column: 0),  BlockPosition(row: 1, column: 1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: -1, column: 1)],
                    [BlockPosition(row: 0, column: 1),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: -1, column: -1)],
                    [BlockPosition(row: 1, column: -1), BlockPosition(row: 0, column: -1),
                     BlockPosition(row: 0, column: 0),  BlockPosition(row: -1, column: 0)]]
        case "J":
            return [[BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: 1, column: 1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: -1, column: 1)],
                    [BlockPosition(row: 0, column: -1), BlockPosition(row: 0, column: 0),
                     BlockPosition(row: 0, column: 1),  BlockPosition(row: -1, column: -1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: 1, column: -1)]]
        case "L":
            return [[BlockPosition(row: 1, column: -1), BlockPosition(row: 0, column: -1),
                     BlockPosition(row: 0, column: 0),  BlockPosition(row: 0, column: 1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: 1, column: 1)],
                    [BlockPosition(row: -1, column: 1), BlockPosition(row: 0, column: -1),
                     BlockPosition(row: 0, column: 0),  BlockPosition(row: 0, column: 1)],
                    [BlockPosition(row: 1, column: 0),  BlockPosition(row: 0, column: 0),
                     BlockPosition(row: -1, column: 0), BlockPosition(row: -1, column: -1)]]
        default:
            return  [[BlockPosition(row: 0, column: 0), BlockPosition(row: 0, column: 0),
                      BlockPosition(row: 0, column: 0), BlockPosition(row: 0, column: 0)]]
        }
    }
    
    // wall kicks are essential to rotate pieces when along the walls
    static func getKicks(blockType: String, rotation: Int, clockwise: Bool) -> [BlockPosition] {
        let rotationCount = getAllBlocks(blockType: blockType).count
        
        var index = rotation % rotationCount
        if index < 0 {index += rotationCount}
        
        var kicks = getAllKicks(blockType: blockType)[index]
        if clockwise == false{
            var counterKicks: [BlockPosition] = []
            for kick in kicks {
                counterKicks.append(BlockPosition(row: -1*kick.row, column: -1*kick.column))
            }
            kicks = counterKicks
        }
        return kicks
    }
    
    static func getAllKicks(blockType: String) -> [[BlockPosition]] {
        switch blockType {
         case "O":
             return [[BlockPosition(row: 0, column: 0)]]
         case "I":
             return [[BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: -2),  BlockPosition(row: 0, column: 1),
                      BlockPosition(row: -1, column: -2), BlockPosition(row: 2, column: -1)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: -1),  BlockPosition(row: 0, column: 2),
                      BlockPosition(row: 2, column: -1),  BlockPosition(row: -1, column: 2)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: 2),   BlockPosition(row: 0, column: -1),
                      BlockPosition(row: 1, column: 2),   BlockPosition(row: -2, column: -1)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: 1),   BlockPosition(row: 0, column: -2),
                      BlockPosition(row: -2, column: 1),  BlockPosition(row: 1, column: -2)]
             ]
         default:
             return [[BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: -1),  BlockPosition(row: 1, column: -1),
                      BlockPosition(row: 0, column: -2),  BlockPosition(row: -2, column: -1)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: 1),   BlockPosition(row: -1, column: 1),
                      BlockPosition(row: 2, column: 0),   BlockPosition(row: 1, column: 2)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: 1),   BlockPosition(row: 1, column: 1),
                      BlockPosition(row: -2, column: 0),  BlockPosition(row: -2, column: 1)],
                     [BlockPosition(row: 0, column: 0),   BlockPosition(row: 0, column: -1),  BlockPosition(row: -1, column: -1),
                      BlockPosition(row: 2, column: 0),   BlockPosition(row: 2, column: -1)]
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
        return TetrisPiece(startPos: origin, blockType: blockType, rotation: 0)
    }
}

