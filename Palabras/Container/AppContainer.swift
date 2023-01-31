import Foundation

@MainActor
final class AppContainer: ObservableObject {
	private lazy var persistenceController: PersistenceController = {
		PersistenceController()
	}()
	private var weakDependencies = [String: WeakContainer]()

	private func getWeak<T: AnyObject>(initialize: () -> T) -> T {
        let id = String(describing: T.self)
        
        if let dependency = weakDependencies[id]?.object as? T {
            return dependency
        }
        
		let object = initialize()
		weakDependencies[id] = .init(object: object)
        
		return object
	}

	private func makeNotificationsSettingsStore() -> NotificationsSettingsStoreImpl {
		getWeak {
			NotificationsSettingsStoreImpl()
		}
	}

	func makeMainAssembly() -> MainAssembly {
		MainAssembly(container: self)
	}

	func makeWordsAssembly() -> WordsAssembly {
		WordsAssembly(container: self)
	}
}

extension AppContainer: MainContainer {
	func makeSettingsAssembly() -> SettingsAssembly {
		SettingsAssembly(container: self)
	}
}

extension AppContainer: WordsContainer {
	func makeWordsService() -> WordsService {
		WordsServiceImpl(persistence: persistenceController)
	}

	func makeWordDetailsAssembly(text: String) -> WordDetailsAssembly {
		WordDetailsAssembly(container: self, text: text)
	}

	func makeNewWordAssembly(output: NewWordOutput?) -> NewWordAssembly {
		NewWordAssembly(container: self, output: output)
	}
}

extension AppContainer: SettingsContainer {
	func makeNotificationsService() -> NotificationsService {
		NotificationsServiceImpl()
	}

	func makeStartNotificationsStore() -> StartNotificationsStore {
		makeNotificationsSettingsStore()
	}

	func makeStopNotificationsStore() -> StopNotificationsStore {
		makeNotificationsSettingsStore()
	}

	func makeNotificationsFrequencyStore() -> NotificationsFrequencyStore & NotificationStoreSaver {
		makeNotificationsSettingsStore()
	}

	func makeStartNotificationsAssembly() -> StartNotificationsAssembly {
		StartNotificationsAssembly(container: self)
	}

	func makeStopNotificationsAssembly() -> StopNotificationsAssembly {
		StopNotificationsAssembly(container: self)
	}

	func makeNotificationsFrequencyAssembly() -> NotificationsFrequencyAssembly {
		NotificationsFrequencyAssembly(container: self)
	}
}
