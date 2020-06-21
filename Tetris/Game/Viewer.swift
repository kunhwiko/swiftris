//
//  Viewer.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/20/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct TetrisGameView: View {
    var game = GameUI()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Swiftris by Kun Hwi Ko")
                .foregroundColor(Color.black)
                .font(.custom("Georgia",size:13))
                .font(.subheadline)
            HStack{
                Spacer()
                    .frame(width:33)
                GeometryReader { geometry in
                    self.initGame(grid: geometry.size)
                }
            }
        }
    }
    
    func initGame(grid: CGSize) -> some View {
        let cols = self.game.cols
        let rows = self.game.rows
        let squareSize = grid.height/CGFloat(rows) // read height of the screen and divide by row size
        let gameBoard = self.game.board
        
        return ForEach(0...rows-1, id:\.self) { row in
            ForEach(0...cols-1, id:\.self) { col in
                Path { path in
                    let x = squareSize * CGFloat(col)
                    let y = grid.height - squareSize*CGFloat(row+1)
                    
                    let rect = CGRect(x: x, y: y, width: squareSize, height: squareSize)
                    path.addRect(rect)
                }
                .fill(gameBoard[row][col].color)
            }
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
