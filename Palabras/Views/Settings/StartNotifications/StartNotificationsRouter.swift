import Foundation

@MainActor
protocol StartNotificationsRouter {
	func stopNotificationsView() -> StopNotificationsView
}

@MainActor
final class StartNotificationsRouterImpl: ObservableObject {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}
}

extension StartNotificationsRouterImpl: StartNotificationsRouter {
	func stopNotificationsView() -> StopNotificationsView {
		container.makeStopNotificationsAssembly().view()
	}
}

@MainActor
final class StartNotificationsRouterPreview: StartNotificationsRouter {
	func stopNotificationsView() -> StopNotificationsView {
		StopNotificationsAssemblyPreview().view()
	}
}
