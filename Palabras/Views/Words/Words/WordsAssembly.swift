import Foundation

protocol WordsContainer {
	func makeWordsService() -> WordsService
	func makeWordDetailsAssembly(text: String) -> WordDetailsAssembly
	func makeNewWordAssembly(output: NewWordOutput?) -> NewWordAssembly
}

@MainActor
final class WordsAssembly {
	private let container: WordsContainer

	init(container: WordsContainer) {
		self.container = container
	}

	func view() -> WordsView {
		let service = container.makeWordsService()
		let router = WordsRouterImpl(container: container)
		let viewModel = WordsViewModel(service: service, router: router)
		return WordsView(viewModel: viewModel)
	}
}

@MainActor
final class WordsAssemblyPreview {
	func view() -> WordsView {
		let service = WordsServicePreview()
		let router = WordsRouterPreview()
		let viewModel = WordsViewModel(service: service, router: router)
		return WordsView(viewModel: viewModel)
	}
}
