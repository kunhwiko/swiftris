//
//  ContentView.swift
//  Tetris
//
//  Created by Kun Hwi Ko on 6/17/20.
//  Copyright © 2020 Kun Hwi Ko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TetrisGameView()
            .background(Color.customBackground)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
