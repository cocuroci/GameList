import SwiftUI
import CoreData

struct GameListView<Model>: View where Model: GameListViewModelInput {
    
    @ObservedObject var viewModel: Model
    @State private var showAddGameView = false
    @State private var showChangeGameStatusAlert = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $viewModel.filterDone) {
                        Text("Mostrar concluídos")
                    }
                    if !viewModel.games.isEmpty {
                        ForEach(viewModel.games) { game in
                            GameListCell(
                                name: game.name,
                                platform: game.platform.name,
                                developers: game.developers,
                                date: game.releaseDateFormatted ?? "",
                                done: game.done
                            ).onTapGesture {
                                self.showChangeGameStatusAlert = true
                            }.alert(isPresented: self.$showChangeGameStatusAlert) {
                                self.showAlert(game: game)
                            }
                        }.onDelete { indexSet in
                            self.viewModel.remove(at: indexSet)
                        }
                    } else {
                        Text("Não existe jogos cadastrados.")
                    }
                }
            }
            .navigationBarTitle("Meus jogos", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddGameView = true
                }) {
                    Image(systemName: "plus").font(.system(size: 24))
                }
            )
        }.sheet(isPresented: $showAddGameView) {
            GameAddFactory.make()
        }
    }
    
    func showAlert(game: Game) -> Alert {
        let title = game.name
        let message = "Alterar status para: \(game.done ? "Não finalizado" : "Finalizado")"
        
        return Alert(
            title: Text(title),
            message: Text(message),
            primaryButton: .default(Text("Alterar"), action: {
                self.viewModel.updateStatus(game: game)
            }),
            secondaryButton: .cancel()
        )
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListFactory.make()
    }
}
