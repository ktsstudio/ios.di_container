import Foundation

protocol MainContainer {
	func makeWordsAssembly() -> WordsAssembly
	func makeSettingsAssembly() -> SettingsAssembly
}

@MainActor
final class MainAssembly {
	private let container: MainContainer

	init(container: MainContainer) {
		self.container = container
	}

	func view() -> MainView {
		let router = MainRouterImpl(container: container)
		let viewModel = MainViewModel(router: router)
		return MainView(viewModel: viewModel)
	}
}

@MainActor
final class MainAssemblyPreview {
	func view() -> MainView {
		let router = MainRouterPreview()
		let viewModel = MainViewModel(router: router)
		return MainView(viewModel: viewModel)
	}
}
