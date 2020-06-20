//
//  Viewer.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/19/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct TetrisGameView: View {
    var tetris = TetrisGameUI()
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            self.draw(boundingRect: geometry.size)
        }
    }
    
    func draw(boundingRect: CGSize) -> some View {
        let columns = self.tetris.cols
        let rows = self.tetris.rows
        let blockSize = min(boundingRect.width/CGFloat(columns),
                            boundingRect.height/CGFloat(rows))
        let colOffset = (boundingRect.width - blockSize*CGFloat(columns))/2
        let rowOffset = (boundingRect.height - blockSize*CGFloat(rows))/2
        let board = self.tetris.board
        
        return ForEach(0...columns-1, id:\.self) { (column:Int) in
            ForEach(0...rows-1, id:\.self) { (row:Int) in
                Path { path in
                    let x = colOffset + blockSize*CGFloat(column)
                    let y = boundingRect.height - rowOffset - blockSize*CGFloat(row+1)
                    let square = CGRect(x:x, y:y, width:blockSize, height:blockSize)
                    path.addRect(square)
                }
                .fill(board[row][column].color)
            }
        
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
