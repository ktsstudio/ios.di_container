import Foundation

@MainActor
final class StopNotificationsAssembly {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}

	func view() -> StopNotificationsView {
		let store = container.makeStopNotificationsStore()
		let router = StopNotificationsRouterImpl(container: container)
		let viewModel = StopNotificationsViewModel(router: router, store: store)
		return StopNotificationsView(viewModel: viewModel)
	}
}

@MainActor
final class StopNotificationsAssemblyPreview {
	func view() -> StopNotificationsView {
		let store = NotificationsSettingsStorePreview()
		let router = StopNotificationsRouterPreview()
		let viewModel = StopNotificationsViewModel(router: router, store: store)
		return StopNotificationsView(viewModel: viewModel)
	}
}
