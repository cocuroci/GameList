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
    
    @Published private(set) var games: [Game] = []
    @Published var filterDone = false
    private var cancellables: Set<AnyCancellable> = []
    
    init(service: GameListServicing) {
        self.service = service
        
        service.fetch().print()
            .assign(to: \.games, on: self)
            .store(in: &cancellables)
        
        $filterDone.print().sink(receiveValue: service.filter(isDone:)).store(in: &cancellables)
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
