//
//  GameUI.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/19/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct Square {
    var color : Color
    var border : Color
}

class GameUI {
    var rows: Int
    var cols: Int
    var board: [[Square]]
    
    // Initialize the board as 20x10 of "Square"s
    init(rows: Int = 20, cols: Int = 10) {
        self.rows = rows
        self.cols = cols
        
        self.board = [[Square]]()
        for _ in 0...rows{
            var rowSquares = [Square]()
            for _ in 0...cols{
                rowSquares.append(Square(color : Color.customBoardColor, border : Color.white))
            }
            self.board.append(rowSquares)
        }
    }
}
