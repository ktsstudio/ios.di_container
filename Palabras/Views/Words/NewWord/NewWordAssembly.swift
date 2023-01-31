import Foundation

@MainActor
final class NewWordAssembly {
	private let container: WordsContainer
	private weak var output: NewWordOutput?

	init(container: WordsContainer, output: NewWordOutput?) {
		self.container = container
		self.output = output
	}

	func view() -> NewWordView {
		let service = container.makeWordsService()
		let viewModel = NewWordViewModel(service: service, output: output)
		return NewWordView(viewModel: viewModel)
	}
}

@MainActor
final class NewWordAssemblyPreview {
	func view() -> NewWordView {
		let service = WordsServicePreview()
		let viewModel = NewWordViewModel(service: service, output: nil)
		return NewWordView(viewModel: viewModel)
	}
}
