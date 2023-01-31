import Foundation
import SwiftUI

@MainActor
final class WordsViewModel: ObservableObject {
	struct Word: Identifiable {
		let id: Int
		let word: String
		let translation: String?
		let imageName: String
		let imageColor: Color
	}

	@Published var words: [Word] = []

	private let service: WordsService
	private let router: WordsRouter
	
	init(service: WordsService, router: WordsRouter) {
		self.service = service
		self.router = router
		reload()
	}

	private func reload() {
		Task {
			do {
				words = try await service.words().enumerated().map { index, word in
					Word(
						id: index,
						word: word.word,
						translation: word.translation,
						imageName: word.isForLearning ? "calendar.badge.clock" : "checkmark.circle.fill",
						imageColor: word.isForLearning ? .black : .green
					)
				}
			} catch {
				print("No items")
			}
		}
	}

	func detailView(by id: Int) -> WordDetailsView? {
		guard let word = words.first(where: { $0.id == id }) else { return nil }
		return router.detailView(with: word.word)
	}

	func deleteWords(at offsets: IndexSet) {
		let wordsToDelete = offsets.map { words[$0].word }
		service.delete(words: wordsToDelete)
		reload()
	}

	func newWordView() -> NewWordView {
		router.newWordView(output: self)
	}
}

extension WordsViewModel: NewWordOutput {
	func saved() {
		reload()
	}
}
