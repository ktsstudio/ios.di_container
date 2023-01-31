import Foundation
import UserNotifications

protocol NotificationsService {
	var isOn: Bool { get }
	func start(with words: [Word])
	func stop()
}

final class NotificationsServiceImpl {
	private let defaults = UserDefaults.standard
	private let notificationCenter = UNUserNotificationCenter.current()
	private var identifiers: [String] = []
}

extension NotificationsServiceImpl: NotificationsService {
	var isOn: Bool {
		defaults.bool(forKey: .isNotificationsOnKey)
	}

	func start(with words: [Word]) {
		let wordsToLearn = words.filter { $0.isForLearning }
		guard !wordsToLearn.isEmpty else { return }
		var index = 0
		let startHour = 0
		let interval = 15
		let stopHour = 24
		var triggerHour = startHour
		var triggerMinute = 0
		while triggerHour < stopHour {
			let word = wordsToLearn[index]
			let content = UNMutableNotificationContent()
			content.title = word.word
//			content.body = word.translation ?? "???"
			content.sound = .default
			var userInfo = ["word": word.word]
			word.translation.map { userInfo["translation"] = $0 }
			content.userInfo = userInfo
			content.categoryIdentifier = word.translation == nil ? "WITHOUT_TRANSLATION" : "REGULAR"

			let dateComponents = DateComponents(hour: triggerHour, minute: triggerMinute)
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

			let id = UUID().uuidString
			let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
			notificationCenter.add(request) { [weak self] error in
				guard error == nil else {
					return
				}
				self?.identifiers.append(id)
			}

			index += 1
			if index == wordsToLearn.count {
				index = 0
			}

			triggerMinute += interval
			if triggerMinute >= 60 {
				triggerMinute = triggerMinute - 60
				triggerHour += 1
			}
		}
	}

	func stop() {
		notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
	}

	func showTranslation(_ translation: String, for word: String) {
		let content = UNMutableNotificationContent()
		content.title = word
		content.body = translation
		content.sound = .default

		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.3, repeats: false)

		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		notificationCenter.add(request) { error in
			guard error == nil else {
				return
			}
		}
	}
}

final class NotificationsServicePreview: NotificationsService {
	var isOn: Bool { true }
	func start(with words: [Word]) {}
	func stop() {}
}

private extension String {
	static var isNotificationsOnKey: String { "isNotificationsOnKey" }
	static var identifiersKey: String { "identifiersKey" }
}
