import Foundation

protocol SettingsContainer {
	func makeNotificationsService() -> NotificationsService
	func makeWordsService() -> WordsService
	func makeStartNotificationsStore() -> StartNotificationsStore
	func makeStopNotificationsStore() -> StopNotificationsStore
	func makeNotificationsFrequencyStore() -> NotificationsFrequencyStore & NotificationStoreSaver
	func makeStartNotificationsAssembly() -> StartNotificationsAssembly
	func makeStopNotificationsAssembly() -> StopNotificationsAssembly
	func makeNotificationsFrequencyAssembly() -> NotificationsFrequencyAssembly
}

@MainActor
final class SettingsAssembly {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}

	func view() -> SettingsView {
		let router = SettingsRouterImpl(container: container)
		let viewModel = SettingsViewModel(
			router: router,
			notificationsService: container.makeNotificationsService(),
			wordsService: container.makeWordsService()
		)
		return SettingsView(viewModel: viewModel)
	}
}

@MainActor
final class SettingsAssemblyPreview {
	func view() -> SettingsView {
		let router = SettingsRouterPreview()
		let viewModel = SettingsViewModel(
			router: router,
			notificationsService: NotificationsServicePreview(),
			wordsService: WordsServicePreview()
		)
		return SettingsView(viewModel: viewModel)
	}
}
