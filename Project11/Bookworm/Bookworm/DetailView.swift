//
//  DetailView.swift
//  Bookworm
//
//  Created by Krzysztof Kostrzewa on 23/11/2020.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false

    let book: Book

    private var formattedCreationDate: String? {
        guard let date = book.createdDate else { return nil }

        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none

        return df.string(from: date)
    }

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)

                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)

                Text("Added at \(formattedCreationDate ?? "N/A")")
                    .font(.caption)
                    .padding()

                Spacer()
            }
        }
        .navigationBarItems(trailing:
            Button(action: { showingDeleteAlert.toggle() }) {
                Image(systemName: "trash")
            })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete book"),
                message: Text("Are you sure?"),
                primaryButton: .destructive(Text("Delete")) { self.deleteBook() },
                secondaryButton: .cancel()
            )
        }
    }

    private func deleteBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = PersistenceController.preview.container.viewContext

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
