//
//  AddGarmentView.swift
//  LL-Tech-Assessment
//
//  Created by Allan Wright on 4/3/20.
//  Copyright © 2020 Allan Wright. All rights reserved.
//

import SwiftUI

struct AddGarmentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode

    // State
    @State private var garmentName: String = ""
    @State private var showingAlert: Bool = false

    // SwiftUI
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Garment Name:").font(.title)) {
                    GarmentNameTextField(contents: $garmentName)
                }
            }
            .navigationBarTitle("Add", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: saveGarment, label: { Text("Save") })
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("No Name"),
                    message: Text("Close without adding a new garment?"),
                    primaryButton: .destructive(Text("Close")) {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    func saveGarment() {
        guard self.garmentName != "" else {
            self.showingAlert = true
            return
        }

        let _: Garment = Garment(name: self.garmentName)

        do {
            try self.managedObjectContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            fatalError("Unable to read managed object context.")
        }
    }
}

struct GarmentNameTextField: View {
    var contents: Binding<String>

    var body: some View {
        UITextField.appearance().clearButtonMode = .whileEditing

        return TextField("Dress, T-Shirt, ...", text: contents)
    }
}

struct AddGarmentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = managedContext()
        return AddGarmentView().environment(\.managedObjectContext, context)
    }
}
