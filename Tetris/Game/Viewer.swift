//
//  Viewer.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/21/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct Viewer: View {
    @ObservedObject var game = GameUI()  // Use observedobject to notify that GameUI is being observed for changes
    
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
                ZStack{
                    // tap left side to rotate counterclockwise
                    GeometryReader { geometry in
                        self.fillLeftGrid(square:geometry.size)
                    }
                    .gesture(game.getMouseGesture())
                    .onTapGesture {
                        self.game.rotatePiece(clockwise: false)
                    }
                        
                    // tap right side to rotate clockwise
                    GeometryReader { geometry in
                        self.fillRightGrid(square:geometry.size)
                    }
                    .gesture(game.getMouseGesture())
                    .onTapGesture {
                        self.game.rotatePiece(clockwise: true)
                    }

                    GeometryReader { geometry in
                        self.fillStroke(square:geometry.size)
                    }
                }
            }
        }
    }
    
    // fill the grid with a specific color
    func fillLeftGrid(square:CGSize) -> some View{
        let gameBoard = self.game.board
        
        return ForEach(0...19, id:\.self) { row in
            ForEach(0...4, id:\.self) { col in
                Path { path in
                    let squareSize = square.height/20
                    let xPos = squareSize * CGFloat(col)
                    let yPos = squareSize * CGFloat(row)
                    
                    let rect = CGRect(x: xPos, y: yPos, width: squareSize, height: squareSize)
                    path.addRect(rect)
                }
                .fill(gameBoard[row][col].color)
            }
        }
    }
    
    // fill the grid with a specific color
    func fillRightGrid(square:CGSize) -> some View{
        let gameBoard = self.game.board
        
        return ForEach(0...19, id:\.self) { row in
            ForEach(5...9, id:\.self) { col in
                Path { path in
                    let squareSize = square.height/20
                    let xPos = squareSize * CGFloat(col)
                    let yPos = squareSize * CGFloat(row)
                    
                    let rect = CGRect(x: xPos, y: yPos, width: squareSize, height: squareSize)
                    path.addRect(rect)
                }
                .fill(gameBoard[row][col].color)
            }
        }
    }
    
    // create dividers in the grid
    func fillStroke(square:CGSize) -> some View{
        ForEach(0...19, id:\.self) { row in
            ForEach(0...9, id:\.self) { col in
                Path { path in
                    let squareSize = square.height/20
                    let xPos = squareSize * CGFloat(col)
                    let yPos = squareSize * CGFloat(row)
                    
                    let rect = CGRect(x: xPos, y: yPos, width: squareSize, height: squareSize)
                    path.addRect(rect)
                }
                .stroke(Color.customLineColor)
            }
        }
    }
}

struct Viewer_Previews: PreviewProvider {
    static var previews: some View {
        Viewer()
    }
}

