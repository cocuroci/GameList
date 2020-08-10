import SwiftUI

struct GameListCell: View {
    let name: String
    let platform: String
    let developers: String
    let date: String
    let done: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text("\(platform) - \(developers)")
                    .font(.caption)
                Text(date)
                    .font(.caption)
            }.foregroundColor(done ? .gray : .black)
            
            Spacer()
            
            if done {
                Image(systemName: "checkmark").foregroundColor(.gray)
            }
        }.background(Color.white)
    }
}

struct GameListCell_Previews: PreviewProvider {
    static var previews: some View {
        GameListCell(
            name: "The Legend of Zelda: Breath of the Wild",
            platform: "Switch",
            developers: "Nintendo",
            date: "03/03/2017",
            done: true
        )
    }
}
