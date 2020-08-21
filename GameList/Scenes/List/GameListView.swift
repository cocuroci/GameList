import SwiftUI
import CoreData

struct GameListView<Model>: View where Model: GameListViewModelInput {
    
    @ObservedObject var viewModel: Model
    @Environment(\.managedObjectContext) var context
    @State private var showAddGameView = false

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $viewModel.filterDone) {
                    Text("Mostrar concluídos")
                }
                ForEach(viewModel.games) { game in
                    GameListCell(game: game).contentShape(Rectangle())
                        .onLongPressGesture {
                            self.viewModel.updateStatus(game: game)
                        }
                }.onDelete {
                    self.viewModel.remove(at: $0)
                }
            }
            .navigationBarTitle("Meus jogos", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showAddGameView.toggle()
                }) {
                    Image(systemName: "plus").font(.system(size: 24))
                }
            )
        }.sheet(isPresented: $showAddGameView) {
            GameAddFactory.make(with: self.context)
        }
    }
}
