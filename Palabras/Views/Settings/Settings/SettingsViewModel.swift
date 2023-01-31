import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
	private let router: SettingsRouter
	private let notificationsService: NotificationsService
	private let wordsService: WordsService

	@Published var isNotificationsOn: Bool = false {
		didSet {
			oldValue ? notificationsService.stop() : start()
		}
	}
	init(router: SettingsRouter, notificationsService: NotificationsService, wordsService: WordsService) {
		self.router = router
		self.notificationsService = notificationsService
		self.wordsService = wordsService
	}

	func startNotificationsView() -> StartNotificationsView {
		router.startNotificationsView()
	}

	private func start() {
		Task {
			do {
				let words = try await wordsService.words()
				notificationsService.start(with: words)
			} catch {}
		}
	}
}

