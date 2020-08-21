import Foundation
import SwiftUI
import CoreData

final class GameEditFactory {
    private init() {}
    
    static func make(withGame game: Game, context: NSManagedObjectContext) -> some View {
        let operations = GameOperations(context: context)
        let service = GameEditService(operations: operations)
        let viewModel = GameEditViewModel(game: game, service: service)
        return GameEditView(viewModel: viewModel)
    }
}
