import SwiftUI
import CoreData

struct GameListViewCoreData: View {
    @FetchRequest(entity: CDGame.entity(), sortDescriptors: [NSSortDescriptor(key: "done", ascending: true),
    NSSortDescriptor(key: "releaseDate", ascending: false)]) var games: FetchedResults<CDGame>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(games, id: \.idWrapped) { game in
                    GameListCell(
                        name: game.nameWrapped,
                        platform: game.platformWrapped.name,
                        developers: game.developersWrapped,
                        date: game.releaseDateWrapped.description,
                        done: game.done
                    )
                }
            }
            .navigationBarTitle("Meus jogos", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    //self.showAddGameView = true
                }) {
                    Image(systemName: "plus").font(.system(size: 24))
                }
            )
        }
    }
}
