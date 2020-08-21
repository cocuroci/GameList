import SwiftUI
import Combine

protocol GameAddViewModelInput: ObservableObject {
    var name: String { get set }
    var plataform: String? { get set }
    var releaseDate: Date { get set }
    var developers: String { get set }
    var done: Bool { get set }
    var formDisabled: Bool { get }
    func addGame()
}

final class GameAddViewModel: GameAddViewModelInput {
    private let service: GameAddServicing
    
    @Published var name = ""
    @Published var plataform: String?
    @Published var releaseDate = Date()
    @Published var developers = ""
    @Published var done = false
    @Published var formDisabled = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: GameAddServicing) {
        self.service = service
        
        let nameValid = $name.map { !$0.isEmpty }
        let plataformValid = $plataform.map { $0?.isEmpty == false }
        let developersValid = $developers.map { !$0.isEmpty }
        
        Publishers.CombineLatest3(nameValid, plataformValid, developersValid).map {
            !$0 || !$1 || !$2
        }
        .assignNoRetain(to: \.formDisabled, on: self)
        .store(in: &cancellables)
    }
    
    deinit {
        debugPrint(#function, self)
    }
    
    func addGame() {
        service.add(
            game: Game(
                id: UUID(),
                name: name,
                platform: Game.Platform(rawValue: plataform?.lowercased() ?? "") ?? Game.Platform.switch,
                releaseDate: releaseDate,
                developers: developers,
                done: done
            )
        )
    }
}
