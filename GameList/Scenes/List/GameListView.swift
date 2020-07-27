import SwiftUI

struct GameListView: View {
    
    var games: [Game]

    var body: some View {
        NavigationView {
            List(games) { game in
                VStack(alignment: .leading) {
                    Text(game.name)
                        .font(.headline)
                    Text("\(game.platform.name) - \(game.developers)")
                        .font(.caption)
                    Text(game.releaseDateFormatted)
                        .font(.caption)
                }
            }
            .navigationBarTitle("Meus jogos")
            .navigationBarItems(trailing:
                Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(games: [Game(name: "Zelda", platform: .switch, releaseDate: Date(), developers: "Nintendo")])
    }
}
