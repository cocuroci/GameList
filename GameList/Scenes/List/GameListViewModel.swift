import SwiftUI
import Combine

protocol GameListViewModelInput: ObservableObject {
    var games: [Game] { get }
    func remove(at indexSet: IndexSet)
}

final class GameListViewModel: GameListViewModelInput {
    private let service: GameListServicing
    
    @Published private(set) var games: [Game] = []
    private var cancellable: AnyCancellable?
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    init(service: GameListServicing) {
        self.service = service
        cancellable = service.fetch()
            .compactMap {
                $0.compactMap { [weak self] game in
                    guard let self = self else { return nil }
                    return Game(
                        id: game.id,
                        name: game.name,
                        platform: game.platform,
                        releaseDate: game.releaseDate,
                        developers: game.developers,
                        releaseDateFormatted: self.dateFormatter.string(from: game.releaseDate)
                    )
                }}
            .assign(to: \.games, on: self)
    }
    
    func remove(at indexSet: IndexSet) {
        for index in indexSet {
            service.delete(game: games.remove(at: index))
        }
    }
}
