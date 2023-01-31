import Foundation

@MainActor
protocol MainRouter {
	func wordsView() -> WordsView
	func settingsView() -> SettingsView
}

@MainActor
final class MainRouterImpl: ObservableObject {
	private let container: MainContainer

	init(container: MainContainer) {
		self.container = container
	}
}

extension MainRouterImpl: MainRouter {
	func wordsView() -> WordsView {
		container.makeWordsAssembly().view()
	}

	func settingsView() -> SettingsView {
		container.makeSettingsAssembly().view()
	}
}

@MainActor
final class MainRouterPreview: MainRouter {
	func wordsView() -> WordsView {
		WordsAssemblyPreview().view()
	}

	func settingsView() -> SettingsView {
		SettingsAssemblyPreview().view()
	}
}
