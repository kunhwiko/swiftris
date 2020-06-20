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
}

class GameUI {
    var rows : Int
    var cols : Int
    var board : [[Square]]
    
    // standard Tetris board is 20x10
    // allow 4 more rows for blocks to drop down
    init(rows:Int = 24, cols:Int = 10){
        self.rows = rows
        self.cols = cols
        
        self.board = [[Square]]()
        for _ in 0...rows{
            var rowSquares = [Square]()
            for _ in 0...cols{
                rowSquares.append(Square(color : Color.customBlack))
            }
            self.board.append(rowSquares)
        }
    }
}
