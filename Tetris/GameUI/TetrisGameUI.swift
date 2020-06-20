//
//  TetrisGameUI.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/19/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct TetrisBoard {
    var color : Color
}

class TetrisGameUI : ObservableObject {
    var rows : Int
    var cols : Int
    var board : [[TetrisBoard]]
    
    init(rows:Int = 23, cols:Int = 10){
        self.rows = rows
        self.cols = cols
        
        self.board = Array(repeating: Array(repeating: TetrisBoard(color: Color.tetrisBlack), count: cols), count: rows)
    }
}
