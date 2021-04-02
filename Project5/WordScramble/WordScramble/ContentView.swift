//
//  ContentView.swift
//  WordScramble
//
//  Created by Krzysztof Kostrzewa on 30/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Score:")
                    Spacer()
                    Text("\(score)")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)

                TextField("Enter your word", text: $newWord, onCommit: addNewWorld)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(word), \(word.count) letters"))
                }
            }

            .navigationTitle(rootWord)
            .navigationBarItems(trailing:
                Button("Restart Game", action: startGame)
            )
        }
        .onAppear(perform: startGame)
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }

    // MARK: - Functions

    private func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt")
        else { fatalError("start.txt missing") }

        guard let startWords = try? String(contentsOf: startWordsURL)
        else { fatalError("start.txt can't be read") }

        let allWords = startWords.components(separatedBy: "\n")

        rootWord = allWords.randomElement() ?? "silkworm"
        score = 0
    }

    private func addNewWorld() {
        let w = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !w.isEmpty else { return }

        guard isOriginal(word: w) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: w) else {
            wordError(title: "Word not recognized", message: "You can't just make words up")
            return
        }

        guard isReal(word: w) else {
            wordError(title: "Word not possible", message: "This ins't a word")
            return
        }

        usedWords.insert(w, at: 0)
        score += w.count * 10
        newWord = ""
    }

    private func wordError(title: String, message: String) {
        errorMessage = message
        errorTitle = title
        showingError.toggle()
    }

    // MARK: - Word Validation Functions

    private func isOriginal(word: String) -> Bool {
        word != rootWord && !usedWords.contains(word)
    }

    private func isPossible(word _: String) -> Bool {
        var root = rootWord
        for char in newWord {
            let idx = root.firstIndex(of: char)
            guard idx != nil else { return false }
            root.remove(at: idx!)
        }

        return true
    }

    private func isReal(word: String) -> Bool {
        guard word.count >= 3 else { return false }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: newWord.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: newWord, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
