//
//  Viewer.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/20/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct TetrisGameView: View {
    var tetrisGame = GameUI()
    
    var body: some View {
        VStack{
            HStack{
                GeometryReader { geometry in
                    Text("SWIFTRIS")
                        .frame(width:geometry.size.width,height:40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                }
            }
            Divider()
            Spacer()
            HStack{
                GeometryReader { (geometry: GeometryProxy) in
                    self.drawBoard(boundingRect: geometry.size)
                }
            }

        }
    }
    
    func drawBoard(boundingRect: CGSize) -> some View {
        let columns = self.tetrisGame.cols
        let rows = self.tetrisGame.rows
        let blocksize = min(boundingRect.width/CGFloat(columns), boundingRect.height/CGFloat(rows))
        let xoffset = (boundingRect.width - blocksize*CGFloat(columns))/2
        let yoffset = (boundingRect.height - blocksize*CGFloat(rows))/2
        let gameBoard = self.tetrisGame.board
        
        return ForEach(0...columns-1, id:\.self) { (column:Int) in
            ForEach(0...rows-1, id:\.self) { (row:Int) in
                Path { path in
                    let x = xoffset + blocksize * CGFloat(column)
                    let y = boundingRect.height - yoffset - blocksize*CGFloat(row+1)
                    
                    let rect = CGRect(x: x, y: y, width: blocksize, height: blocksize)
                    path.addRect(rect)
                }
                .fill(gameBoard[row][column].color)
            }
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
