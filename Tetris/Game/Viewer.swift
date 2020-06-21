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
                ZStack{
                    GeometryReader { geometry in
                        self.fillGrid(square:geometry.size)
                    }
                    GeometryReader { geometry in
                        self.fillStroke(square:geometry.size)
                    }
                }
            }
        }
    }
    
    // fill the grid with a specific color
    func fillGrid(square:CGSize) -> some View{
        ForEach(0...19, id:\.self) { row in
            ForEach(0...9, id:\.self) { col in
                Path { path in
                    let squareSize = square.height/20
                    let xPos = squareSize * CGFloat(col)
                    let yPos = squareSize * CGFloat(row)
                    
                    let rect = CGRect(x: xPos, y: yPos, width: squareSize, height: squareSize)
                    path.addRect(rect)
                }
                .fill(Color.customBoardColor)
            }
        }
    }
    
    // create dividers for the squares in the grid
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

struct TetrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisGameView()
    }
}
