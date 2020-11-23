//
//  AddBookView.swift
//  Bookworm
//
//  Created by Krzysztof Kostrzewa on 22/11/2020.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    private let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    private var canSave: Bool {
        !title.isEmpty && !author.isEmpty && !genre.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)

                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.createdDate = Date()

                        try? moc.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(!canSave)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
