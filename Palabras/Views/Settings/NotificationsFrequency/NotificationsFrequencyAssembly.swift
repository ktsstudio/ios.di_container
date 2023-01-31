import Foundation

@MainActor
final class NotificationsFrequencyAssembly {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}

	func view() -> NotificationsFrequencyView {
		let store = container.makeNotificationsFrequencyStore()
		let router = NotificationsFrequencyRouterImpl(container: container)
		let viewModel = NotificationsFrequencyViewModel(router: router, store: store)
		return NotificationsFrequencyView(viewModel: viewModel)
	}
}

@MainActor
final class NotificationsFrequencyAssemblyPreview {
	func view() -> NotificationsFrequencyView {
		let store = NotificationsSettingsStorePreview()
		let router = NotificationsFrequencyRouterPreview()
		let viewModel = NotificationsFrequencyViewModel(router: router, store: store)
		return NotificationsFrequencyView(viewModel: viewModel)
	}
}
