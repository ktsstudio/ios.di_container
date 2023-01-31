import Foundation
import UserNotifications

@MainActor
final class MainViewModel: ObservableObject {
	private let router: MainRouter
	private let notificationsReciever = NotificationsReciever()

	init(router: MainRouter) {
		self.router = router
		let center = UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }

		// Define the custom actions.
		let addTranslationAction = UNTextInputNotificationAction(
			identifier: "ADD_TRANSLATION",
			title: "Add translation",
			options: []
		)
		let showTranslationAction = UNNotificationAction(
			identifier: "SHOW_TRANSLATION",
			title: "Show translation",
			options: []
		)
		let stopLearningAction = UNNotificationAction(
			identifier: "STOP_LEARNING",
			title: "Stop learning",
			options: []
		)
		// Define the notification type
		let withoutTranslationCategory = UNNotificationCategory(
			identifier: "WITHOUT_TRANSLATION",
			actions: [addTranslationAction, stopLearningAction],
			intentIdentifiers: [],
			hiddenPreviewsBodyPlaceholder: ""
		)
		let regularCategory = UNNotificationCategory(
			identifier: "REGULAR",
			actions: [showTranslationAction, stopLearningAction],
			intentIdentifiers: [],
			hiddenPreviewsBodyPlaceholder: ""
		)
		// Register the notification type.
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.setNotificationCategories([withoutTranslationCategory, regularCategory])
		notificationCenter.delegate = notificationsReciever
	}

	func wordsView() -> WordsView {
		router.wordsView()
	}

	func settingsView() -> SettingsView {
		router.settingsView()
	}
}

final class NotificationsReciever: NSObject, UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		// Get the meeting ID from the original notification.
		let userInfo = response.notification.request.content.userInfo
		guard let word = userInfo["word"] as? String else {
			completionHandler()
			return
		}

		// Perform the task associated with the action.
		switch response.actionIdentifier {
		case "SHOW_TRANSLATION":
			guard let translation = userInfo["translation"] as? String else {
				completionHandler()
				return
			}
			let notificationService = NotificationsServiceImpl()
			notificationService.showTranslation(translation, for: word)
		default:
			break
		}

		// Always call the completion handler when done.
		completionHandler()
	}
}
