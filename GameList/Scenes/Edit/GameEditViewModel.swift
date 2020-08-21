import SwiftUI
import Combine

protocol GameEditViewModelInput: ObservableObject {
    var game: Game { get }
    var name: String { get set }
    var plataform: String? { get set }
    var releaseDate: Date { get set }
    var developers: String { get set }
    var done: Bool { get set }
    var formDisabled: Bool { get }
    func update()
}

final class GameEditViewModel: GameEditViewModelInput {
    private(set) var game: Game
    private let service: GameEditServicing
    
    @Published var name: String
    @Published var plataform: String?
    @Published var releaseDate: Date
    @Published var developers: String
    @Published var done: Bool
    @Published var formDisabled: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
       
    init(game: Game, service: GameEditServicing) {
        self.game = game
        self.service = service
        
        _name = Published(initialValue: game.name)
        _plataform = Published(initialValue: game.platform.name)
        _releaseDate = Published(initialValue: game.releaseDate)
        _developers = Published(initialValue: game.developers)
        _done = Published(initialValue: game.done)
        
        let nameValid = $name.map { !$0.isEmpty }
        let plataformValid = $plataform.map { $0?.isEmpty == false }
        let developersValid = $developers.map { !$0.isEmpty }
        
        Publishers.CombineLatest3(nameValid, plataformValid, developersValid).map {
           !$0 || !$1 || !$2
        }
        .print()
        .assignNoRetain(to: \.formDisabled, on: self)
        .store(in: &cancellables)
    }
    
    deinit {
        debugPrint(#function, self)
    }
    
    func update() {
        let updatedGame = Game(
            id: game.id,
            name: name,
            platform: Game.Platform(rawValue: plataform?.lowercased() ?? "") ?? Game.Platform.switch,
            releaseDate: releaseDate,
            developers: developers,
            done: done
        )
        
        service.update(game: updatedGame)
    }
}
