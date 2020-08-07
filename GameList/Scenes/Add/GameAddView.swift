//
//  GameAddView.swift
//  GameList
//
//  Created by André Martins on 27/07/20.
//  Copyright © 2020 André Cocuroci. All rights reserved.
//

import SwiftUI
import CoreData

struct GameAddView<Model>: View where Model: GameAddViewModelInput {
    @ObservedObject var viewModel: Model
    
    @State private var name = ""
    @State private var developer = ""
    @State private var releaseDate = Date()
    @State private var selectedPlatform: String?
    @State private var done = false
    @Environment(\.presentationMode) var presentationMode
    
    private let platform = Game.Platform.allCases

    var body: some View {
        NavigationView {
            Form {
                TextField("Nome", text: $name)
                TextField("Desenvolvedora", text: $developer)
                DatePicker(selection: $releaseDate, displayedComponents: .date) {
                    Text("Data de lançamento")
                }
                Picker(selection: $selectedPlatform, label: Text("Plataforma")) {
                    Text("Escolha").tag(String?.none)
                    ForEach(platform, id: \.self) { (platform: Game.Platform?) in
                        Text(platform?.name ?? "").tag(platform?.name)
                    }
                }
                Toggle(isOn: $done) {
                    Text("Concluído")
                }
            }
            .navigationBarTitle("Adicionar", displayMode: .inline)
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
        }
    }
    
    private func saveGame() {
        viewModel.addGame(with: name, plataform: selectedPlatform, releaseDate: releaseDate, developers: developer, done: done)
    }
    
    private func closeModal() {
        presentationMode.wrappedValue.dismiss()
    }
}
