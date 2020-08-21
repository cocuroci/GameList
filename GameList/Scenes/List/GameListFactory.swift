import Foundation
import SwiftUI
import CoreData

final class GameListFactory {
    private init() {}
    
    static func make(with context: NSManagedObjectContext) -> some View {
        let operations = GameOperations(context: context)
        let service = GameListService(operations: operations)
        let viewModel = GameListViewModel(service: service)
        return GameListView(viewModel: viewModel)
    }
}
