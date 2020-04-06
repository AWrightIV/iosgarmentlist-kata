//
//  ContentView.swift
//  LL-Tech-Assessment
//
//  Created by Allan Wright on 4/3/20.
//  Copyright © 2020 Allan Wright. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // Core Data
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: Garment.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Garment.name, ascending: true)
        ]
    ) var garmentsByName: FetchedResults<Garment>

    @FetchRequest(
        entity: Garment.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Garment.created, ascending: true)
        ]
    ) var garmentsByCreated: FetchedResults<Garment>

    // State
    @State private var pickerLabels: [String] = ["Alpha", "Creation Time"]
    @State private var selectedSegment: Int = 0
    @State private var showAddView: Bool = false

    // SwiftUI
    var body: some View {
        return NavigationView {
            VStack {
                Section {
                    Picker(selection: $selectedSegment, label: Text("")) {
                        ForEach(0 ..< pickerLabels.count) {
                            Text(self.pickerLabels[$0]).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal, .some(CGFloat(4)))
                .padding(.top, .some(CGFloat(8)))

                Section {
                    GarmentList(garments: sortedGarments())
                }
            }
            .navigationBarTitle(Text("List"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(
                    action: pushAddView,
                    label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                    }
                )
            )
            .sheet(isPresented: $showAddView) {
                AddGarmentView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }

    func sortedGarments() -> FetchedResults<Garment> {
        if (selectedSegment == 0) {
            return garmentsByName
        } else {
            return garmentsByCreated
        }
    }

    func pushAddView() {
        self.showAddView = true
    }
}

struct GarmentCell: View {
    let garment: Garment

    var body: some View {
        Text(garment.name)
    }
}

struct GarmentList: View {
    let garments: FetchedResults<Garment>

    var body: some View {
        List {
            ForEach(garments) { garment in
                GarmentCell(garment: garment)
            }
        }
        .border(Color.black, width: CGFloat(1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = managedContext()
        return ContentView().environment(\.managedObjectContext, context)
    }
}
