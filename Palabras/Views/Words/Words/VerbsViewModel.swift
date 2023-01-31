//
//  WordsViewModel.swift
//  Palabras
//
//  Created by Aleksandr Anosov on 15.09.22.
//

import Foundation

@MainActor
final class WordsViewModel: ObservableObject {
	struct Word: Identifiable {
		let id: Int
		let text: String
	}

	@Published var Words: [Word] = []

	private let service: WordsService
	private let router: WordsRouter
	
	init(service: WordsService, router: WordsRouter) {
		self.service = service
		self.router = router
		Task {
			do {
				Words = try await service.Words().enumerated().map { index, Word in
					Word(id: index, text: itemFormatter.string(from: Word.timestamp))
				}
			} catch {
				print("No items")
			}
		}
	}

	func detailView(by id: Int) -> WordDetailsView? {
		guard let Word = Words.first(where: { $0.id == id }) else { return nil }
		return router.detailView(with: Word.text)
	}
}

private let itemFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	formatter.timeStyle = .medium
	return formatter
}()
