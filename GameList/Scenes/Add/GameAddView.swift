import SwiftUI
import CoreData

struct GameAddView<Model>: View where Model: GameAddViewModelInput {
    @ObservedObject var viewModel: Model
    @Environment(\.presentationMode) var presentationMode
    
    private let platform = Game.Platform.allCases

    var body: some View {
        NavigationView {
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
            .navigationBarTitle("Adicionar jogo", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    private var cancelButton: some View {
        Button("Cancelar") {
            self.closeModal()
        }
    }
    
    private var saveButton: some View {
        Button("Salvar") {
            self.saveGame()
            self.closeModal()
        }.disabled(viewModel.formDisabled)
    }
    
    private func saveGame() {
        viewModel.addGame()
    }
    
    private func closeModal() {
        presentationMode.wrappedValue.dismiss()
    }
}
