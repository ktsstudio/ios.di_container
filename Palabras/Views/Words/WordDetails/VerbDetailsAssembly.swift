//
//  WordDetailsAssembly.swift
//  Palabras
//
//  Created by Aleksandr Anosov on 15.09.22.
//

import Foundation

final class WordDetailsAssembly {
	private let text: String
	private let container: WordsContainer

	init(container: WordsContainer, text: String) {
		self.text = text
		self.container = container
	}

	@MainActor func view() -> WordDetailsView {
		let service = container.makeWordsService()
		let viewModel = WordDetailsViewModel(service: service, text: text)
		return WordDetailsView(viewModel: viewModel)
	}
}

final class WordDetailsAssemblyPreview {
	@MainActor func view() -> WordDetailsView {
		let service = WordsServicePreview()
		let viewModel = WordDetailsViewModel(service: service, text: "Preview text")
		return WordDetailsView(viewModel: viewModel)
	}
}
