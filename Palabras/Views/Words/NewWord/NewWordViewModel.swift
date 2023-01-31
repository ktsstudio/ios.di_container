import Foundation

protocol NewWordOutput: AnyObject {
	func saved()
}

@MainActor
final class NewWordViewModel: ObservableObject {

	@Published var word: String = ""
	@Published var translation: String = ""
	@Published var isForLearning: Bool = true

	private var service: WordsService
	private weak var output: NewWordOutput?

	init(service: WordsService, output: NewWordOutput?) {
		self.service = service
		self.output = output
	}

	func onSave() {
		guard !word.isEmpty else { return }
		service.add(word: Word(word: word, translation: translation, isForLearning: isForLearning))
		output?.saved()
	}
}
