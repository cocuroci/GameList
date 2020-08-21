import SwiftUI

struct GameListCell: View {
    let game: Game
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                Text("\(game.platform.name) - \(game.developers)")
                    .font(.caption)
                Text(game.releaseDateFormatted ?? "")
                    .font(.caption)
            }.foregroundColor(game.done ? .gray : .primary)
            
            Spacer()
            
            if game.done {
                Image(systemName: "checkmark").foregroundColor(.gray)
            }
        }
    }
}
