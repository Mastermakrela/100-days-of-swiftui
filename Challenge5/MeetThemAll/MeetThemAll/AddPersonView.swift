//
//  AddPersonView.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 04.04.21.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var people: [Person]
    let locationFetcher = LocationFetcher()

    @State private var name = ""
    @State private var image: UIImage?
    @State private var showImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle().fill(Color.secondary)

                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Text("Tap to take a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showImagePicker.toggle()
                }
                .frame(width: 250, height: 350)

                TextField("Person's name", text: $name)
                    .padding()

                Button("Save") {
                    print("save")
                    guard !name.isEmpty,
                          let img = image,
                          let location = locationFetcher.lastKnownLocation
                    else { return }

                    if let newPerson = Person(name: name, image: img, location: location) {
                        people.append(newPerson)
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Person")
            .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(image: $image)
            })
        }
        .onAppear {
            locationFetcher.start()
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(people: .constant([]))
    }
}
