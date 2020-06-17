//
//  File.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/17/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

class GameUI: ObservableObject{
    var rows : Int
    var cols : Int
    var board : [[TetrisGameSquare]]
    
    init (rows : Int = 23, cols : Int = 10) {
        self.rows = rows
        self.cols = cols
    }
}

struct TetrisGameSquare {
    var color : Color
}
