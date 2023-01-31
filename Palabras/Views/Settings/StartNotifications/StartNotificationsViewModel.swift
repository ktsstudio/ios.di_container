import Foundation

@MainActor
final class StartNotificationsViewModel: ObservableObject {
	private let router: StartNotificationsRouter
	private let store: StartNotificationsStore

	@Published var date: Date = Date()

	init(
        router: StartNotificationsRouter,
        store: StartNotificationsStore
    ) {
		self.router = router
		self.store = store
        
		_ = store.statePublisher.sink { [weak self] state in
			self?.date = state.startDate
		}
	}

	func stopNotificationsView() -> StopNotificationsView {
		store.setStartDate(date)
		return router.stopNotificationsView()
	}
}
