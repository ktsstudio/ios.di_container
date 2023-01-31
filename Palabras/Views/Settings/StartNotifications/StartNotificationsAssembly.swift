import Foundation

@MainActor
final class StartNotificationsAssembly {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}

	func view() -> StartNotificationsView {
		let store = container.makeStartNotificationsStore()
		let router = StartNotificationsRouterImpl(container: container)
		let viewModel = StartNotificationsViewModel(router: router, store: store)
		return StartNotificationsView(viewModel: viewModel)
	}
}

@MainActor
final class StartNotificationsAssemblyPreview {
	func view() -> StartNotificationsView {
		let store = NotificationsSettingsStorePreview()
		let router = StartNotificationsRouterPreview()
		let viewModel = StartNotificationsViewModel(router: router, store: store)
		return StartNotificationsView(viewModel: viewModel)
	}
}
