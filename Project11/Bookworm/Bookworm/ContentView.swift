//
//  ContentView.swift
//  Bookworm
//
//  Created by Krzysztof Kostrzewa on 21/11/2020.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Book.title, ascending: true),
            NSSortDescriptor(keyPath: \Book.author, ascending: true),
        ]
    ) var books: FetchedResults<Book>

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating <= 1 ? .red : .primary)

                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle(Text("Bookworm"))
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button { showingAddScreen.toggle() }
                label: { Image(systemName: "plus") }
            )
            .sheet(isPresented: $showingAddScreen) {
                AddBookView().environment(\.managedObjectContext, moc)
            }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        offsets.forEach { moc.delete(books[$0]) }
        try? moc.save()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
