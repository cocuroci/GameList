import Foundation
import SwiftUI
import CoreData

final class GameAddFactory {
    private init() {}
    
    static func make(with context: NSManagedObjectContext = CoreDataContainer.shared.context) -> some View {
        let operation = GameOperations(context: context)
        let service = GameAddService(operations: operation)
        let viewModel = GameAddViewModel(service: service)
        return GameAddView(viewModel: viewModel).environment(\.locale, .init(identifier: "pt_BR_POSIX"))
    }
}
