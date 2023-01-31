import Foundation

@MainActor
final class WordDetailsViewModel: ObservableObject {

	@Published var word: String = ""
	@Published var translation: String = ""
	@Published var isForLearning: Bool = true

	private var service: WordsService

	init(service: WordsService, text: String) {
		self.service = service
		Task {
			do {
				guard let fullWord = try await service.word(by: text) else {
					return
				}
				word = fullWord.word
				translation = fullWord.translation ?? "???"
				isForLearning = fullWord.isForLearning
			} catch {}
		}
	}

	func onSave() {
		guard !word.isEmpty else { return }
		service.edit(word: Word(word: word, translation: translation, isForLearning: isForLearning))
	}
}
