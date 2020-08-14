import SwiftUI
import Combine

protocol GameListViewModelInput: ObservableObject {
    var games: [Game] { get }
    var filterDone: Bool { get set }
    func remove(at indexSet: IndexSet)
    func updateStatus(game: Game)
}

final class GameListViewModel: GameListViewModelInput {
    private let service: GameListServicing
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var games: [Game] = []
    @Published var filterDone = false
    
    init(service: GameListServicing) {
        self.service = service
        
        service.fetch()
            .assign(to: \.games, on: self)
            .store(in: &cancellables)
        
        $filterDone.sink(receiveValue: service.filter(isDone:)).store(in: &cancellables)
    }
    
    func remove(at indexSet: IndexSet) {
        for index in indexSet {
            service.delete(game: games.remove(at: index))
        }
    }
    
    func updateStatus(game: Game) {
        service.updateStatus(game: game)
    }
}
