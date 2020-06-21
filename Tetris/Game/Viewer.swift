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
                    ForEach(0...19, id:\.self) { row in
                        ForEach(0...9, id:\.self) { col in
                            Path { path in
                                let squareSize = geometry.size.height/CGFloat(20)
                                let x = squareSize * CGFloat(col)
                                let y = geometry.size.height - squareSize*CGFloat(row+1)
                                
                                let rect = CGRect(x: x, y: y, width: squareSize, height: squareSize)
                                path.addRect(rect)
                            }
                            .fill(self.game.board[row][col].color)
                        }
                    }
                }
            }
        }
    }
}

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
