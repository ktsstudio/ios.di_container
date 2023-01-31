import Foundation

@MainActor
protocol StopNotificationsRouter {
	func notificationsFrequencyView() -> NotificationsFrequencyView
}

@MainActor
final class StopNotificationsRouterImpl: ObservableObject {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}
}

extension StopNotificationsRouterImpl: StopNotificationsRouter {
	func notificationsFrequencyView() -> NotificationsFrequencyView {
		container.makeNotificationsFrequencyAssembly().view()
	}
}

@MainActor
final class StopNotificationsRouterPreview: StopNotificationsRouter {
	func notificationsFrequencyView() -> NotificationsFrequencyView {
		NotificationsFrequencyAssemblyPreview().view()
	}
}
