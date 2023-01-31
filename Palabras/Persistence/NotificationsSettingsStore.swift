import Foundation

struct NotificationsSettingsState: Codable {
	let startDate: Date
	let stopDate: Date
	let frequency: Int

	init(
		startDate: Date = Date(),
		stopDate: Date = Date(),
		frequency: Int = 15
	) {
		self.startDate = startDate
		self.stopDate = stopDate
		self.frequency = frequency
	}
}

protocol StartNotificationsStore: AnyObject {
	var statePublisher: Published<NotificationsSettingsState>.Publisher { get }
	func setStartDate(_ date: Date)
}

protocol StopNotificationsStore: AnyObject {
	var statePublisher: Published<NotificationsSettingsState>.Publisher { get }
	func setStopDate(_ date: Date)
}

protocol NotificationsFrequencyStore: AnyObject {
	var statePublisher: Published<NotificationsSettingsState>.Publisher { get }
	func setFrequency(_ frequency: Int)
}

protocol NotificationStoreSaver: AnyObject {
      func save()
}

final class NotificationsSettingsStoreImpl {
	@Published private var state: NotificationsSettingsState

	init() {
		guard let settingsString = UserDefaults.standard.string(forKey: .notificationsSettingsKey),
			  let settingsData = settingsString.data(using: .utf8) else {
			state = .init()
			return
		}
		state = (try? JSONDecoder().decode(NotificationsSettingsState.self, from: settingsData)) ?? .init()
	}

	var statePublisher: Published<NotificationsSettingsState>.Publisher {
		$state
	}
}

extension NotificationsSettingsStoreImpl: StartNotificationsStore {
	func setStartDate(_ date: Date) {
		state = NotificationsSettingsState(startDate: date, stopDate: state.stopDate, frequency: state.frequency)
	}
}

extension NotificationsSettingsStoreImpl: StopNotificationsStore {
	func setStopDate(_ date: Date) {
		state = NotificationsSettingsState(startDate: state.startDate, stopDate: date, frequency: state.frequency)
	}
}

extension NotificationsSettingsStoreImpl: NotificationsFrequencyStore {
	func setFrequency(_ frequency: Int) {
		state = NotificationsSettingsState(startDate: state.startDate, stopDate: state.stopDate, frequency: frequency)
	}
}

extension NotificationsSettingsStoreImpl: NotificationStoreSaver {
    func save() {
        guard let settingsData = try? JSONEncoder().encode(state),
              let settingsString = String(data: settingsData, encoding: .utf8) else {
            return
        }
        UserDefaults.standard.set(settingsString, forKey: .notificationsSettingsKey)
    }
}

final class NotificationsSettingsStorePreview: StartNotificationsStore, StopNotificationsStore, NotificationsFrequencyStore, NotificationStoreSaver {
	@Published private var state = NotificationsSettingsState()

	var statePublisher: Published<NotificationsSettingsState>.Publisher {
		$state
	}
	func setStartDate(_ date: Date) {}
	func setStopDate(_ date: Date) {}
	func setFrequency(_ frequency: Int) {}
	func save() {}
}

private extension String {
	static var notificationsSettingsKey: String { "notificationsSettingsKey" }
}
