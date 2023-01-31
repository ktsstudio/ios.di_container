import Foundation

@MainActor
protocol SettingsRouter {
	func startNotificationsView() -> StartNotificationsView
}

@MainActor
final class SettingsRouterImpl: ObservableObject {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}
}

extension SettingsRouterImpl: SettingsRouter {
	func startNotificationsView() -> StartNotificationsView {
		container.makeStartNotificationsAssembly().view()
	}
}

@MainActor
final class SettingsRouterPreview: SettingsRouter {
	func startNotificationsView() -> StartNotificationsView {
		StartNotificationsAssemblyPreview().view()
	}
}
