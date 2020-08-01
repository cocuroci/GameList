import SwiftUI
import CoreData

struct GameListView<Model>: View where Model: GameListViewModelInput {
    
    @ObservedObject var viewModel: Model
    @State private var showAddGameView = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.games.count > 0 {
                    List {
                        ForEach(viewModel.games) { game in
                            GameListCell(
                                name: game.name,
                                platform: game.platform.name,
                                developers: game.developers,
                                date: game.releaseDateFormatted ?? ""
                            )
                        }.onDelete { indexSet in
                            self.viewModel.remove(at: indexSet)
                        }
                    }
                } else {
                    Text("Não existe jogos cadastrados")
                    Button("Adicionar jogo") {
                        self.showAddGameView = true
                    }
                }
            }
            .navigationBarTitle("Meus jogos")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddGameView = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }.sheet(isPresented: $showAddGameView) {
            GameAddFactory.make()
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListFactory.make()
    }
}
