import Foundation

@MainActor
protocol NotificationsFrequencyRouter {

}

@MainActor
final class NotificationsFrequencyRouterImpl: ObservableObject {
	private let container: SettingsContainer

	init(container: SettingsContainer) {
		self.container = container
	}
}

extension NotificationsFrequencyRouterImpl: NotificationsFrequencyRouter {

}

@MainActor
final class NotificationsFrequencyRouterPreview: NotificationsFrequencyRouter {

}
