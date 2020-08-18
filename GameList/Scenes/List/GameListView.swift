import SwiftUI
import CoreData

struct LazyView<Content: View>: View {
    private let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}

struct GameListView<Model>: View where Model: GameListViewModelInput {
    
    @ObservedObject var viewModel: Model
    @State private var showAddGameView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $viewModel.filterDone) {
                        Text("Mostrar concluídos")
                    }
                    ForEach(viewModel.games) { game in
                        NavigationLink(destination: LazyView(GameEditFactory.make(withGame: game))) {
                            GameListCell(
                                name: game.name,
                                platform: game.platform.name,
                                developers: game.developers,
                                date: game.releaseDateFormatted ?? "",
                                done: game.done
                            )
                        }
                        
                    }.onDelete {
                        self.viewModel.remove(at: $0)
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
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListFactory.make()
    }
}
