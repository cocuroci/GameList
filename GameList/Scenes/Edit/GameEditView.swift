import SwiftUI

struct GameEditView<Model>: View where Model: GameEditViewModelInput {
    @ObservedObject var viewModel: Model
    @Environment(\.presentationMode) var presentationMode
    
    private let platform = Game.Platform.allCases
    
    var body: some View {
        Form {
            TextField("Nome", text: $viewModel.name)
            TextField("Desenvolvedora", text: $viewModel.developers)
            DatePicker(selection: $viewModel.releaseDate, displayedComponents: .date) {
                Text("Data de lançamento")
            }
            Picker(selection: $viewModel.plataform, label: Text("Plataforma")) {
                Text("Escolha").tag(String?.none)
                ForEach(platform, id: \.self) { (platform: Game.Platform?) in
                    Text(platform?.name ?? "").tag(platform?.name)
                }
            }
            Toggle(isOn: $viewModel.done) {
                Text("Concluído")
            }
        }
        .navigationBarTitle("Editar jogo")
        .navigationBarItems(trailing: updateButton)
    }
    
    private var updateButton: some View {
        Button("Salvar") {
            self.viewModel.update()
            self.presentationMode.wrappedValue.dismiss()
        }.disabled(viewModel.formDisabled)
    }
}
