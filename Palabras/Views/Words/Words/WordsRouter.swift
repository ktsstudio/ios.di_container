import Foundation

@MainActor
protocol WordsRouter {
	func detailView(with text: String) -> WordDetailsView
	func newWordView(output: NewWordOutput?) -> NewWordView
}

@MainActor
final class WordsRouterImpl: ObservableObject {
	private let container: WordsContainer

	init(container: WordsContainer) {
		self.container = container
	}
}

extension WordsRouterImpl: WordsRouter {
	func detailView(with text: String) -> WordDetailsView {
		container.makeWordDetailsAssembly(text: text).view()
	}

	func newWordView(output: NewWordOutput?) -> NewWordView {
		container.makeNewWordAssembly(output: output).view()
	}
}

@MainActor
final class WordsRouterPreview: WordsRouter {
	func detailView(with text: String) -> WordDetailsView {
		WordDetailsAssemblyPreview().view()
	}

	func newWordView(output: NewWordOutput?) -> NewWordView {
		NewWordAssemblyPreview().view()
	}
}
