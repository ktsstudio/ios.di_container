import Foundation

protocol WordsService {
	func words() async throws -> [Word]
	func add(word: Word)
	func delete(words: [String])
	func word(by text: String) async throws -> Word?
	func edit(word: Word)
}

final class WordsServiceImpl {
	private let persistence: PersistenceController

	init(persistence: PersistenceController) {
		self.persistence = persistence
	}
}

extension WordsServiceImpl: WordsService {
	func words() async throws -> [Word] {
		let words: [WordManaged] = try persistence.container.viewContext.fetch(.init(entityName: "WordManaged"))
		return words.map {
			Word(word: $0.word!, translation: $0.translation, isForLearning: $0.isForLearning)
		}
	}

	func add(word: Word) {
		let viewContext = persistence.container.viewContext
		let newWord = WordManaged(context: viewContext)
		newWord.word = word.word
		newWord.translation = word.translation
		newWord.isForLearning = word.isForLearning

		do {
			try viewContext.save()
		} catch {
			// Replace this implementation with code to handle the error appropriately.
			// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}

	func delete(words: [String]) {
		let viewContext = persistence.container.viewContext
		let wordsManaged: [WordManaged] = (try? persistence.container.viewContext.fetch(.init(entityName: "WordManaged"))) ?? []
		words.forEach { word in
			wordsManaged.filter { $0.word == word }.forEach {
				viewContext.delete($0)
			}
		}
		try? viewContext.save()
	}

	func word(by text: String) async throws -> Word? {
		try await words().first { $0.word == text }
	}

	func edit(word: Word) {
		do {
			let words: [WordManaged] = try persistence.container.viewContext.fetch(.init(entityName: "WordManaged"))
			guard let wordManaged = words.first(where: { word.word == $0.word }) else {
				return
			}
			let viewContext = persistence.container.viewContext
			wordManaged.word = word.word
			wordManaged.translation = word.translation
			wordManaged.isForLearning = word.isForLearning
			try viewContext.save()
		} catch {}
	}
}

final class WordsServicePreview: WordsService {
	func words() async throws -> [Word] {
		[
			Word(word: "La revista", translation: "The magazine", isForLearning: true),
			Word(word: "Cual", translation: "Which", isForLearning: true),
			Word(word: "Pobre", translation: "Poor", isForLearning: false)
		]
	}

	func add(word: Word) {}
	func delete(words: [String]) {}
	func word(by text: String) async throws -> Word? {
		Word(word: "La revista", translation: "The magazine", isForLearning: true)
	}
	func edit(word: Word) {}
}
