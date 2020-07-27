//
//  GameListView.swift
//  GameList
//
//  Created by André Martins on 21/07/20.
//  Copyright © 2020 André Cocuroci. All rights reserved.
//

import SwiftUI

struct GameListView: View {
    
    var games = [Game]()
    
    var body: some View {
        NavigationView {
            List(games) {
                Text($0.name)
            }
        }
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}
