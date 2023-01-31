import Foundation

enum NotificationsFrequency: Int, CaseIterable, Identifiable {
	case ten = 10
	case fifteen = 15
	case thirty = 30

	var id: Self { self }

	var minutes: Int {
		rawValue * 60
	}
}

@MainActor
final class NotificationsFrequencyViewModel: ObservableObject {
	private let router: NotificationsFrequencyRouter
	private let store: NotificationsFrequencyStore & NotificationStoreSaver

	@Published var frequency: NotificationsFrequency = .fifteen

	init(router: NotificationsFrequencyRouter, store: NotificationsFrequencyStore & NotificationStoreSaver) {
		self.router = router
		self.store = store
		_ = store.statePublisher.sink { [weak self] state in
			self?.frequency = .init(rawValue: state.frequency) ?? .fifteen
		}
	}

	func onSave() {
		store.setFrequency(frequency.rawValue)
		store.save()
	}
}
