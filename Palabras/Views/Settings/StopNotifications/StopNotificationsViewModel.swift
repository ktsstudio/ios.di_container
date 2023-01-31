import Foundation

@MainActor
final class StopNotificationsViewModel: ObservableObject {
	private let router: StopNotificationsRouter
	private let store: StopNotificationsStore

	@Published var date: Date = Date()

	init(router: StopNotificationsRouter, store: StopNotificationsStore) {
		self.router = router
		self.store = store
		_ = store.statePublisher.sink { [weak self] state in
			self?.date = state.stopDate
		}
	}

	func notificationsFrequencyView() -> NotificationsFrequencyView {
		store.setStopDate(date)
		return router.notificationsFrequencyView()
	}
}
