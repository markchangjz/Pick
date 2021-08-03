import UIKit

private let candidateKey = "CandidateKey"
private let notificationDateHourKey = "NotificationDateHourKey"
private let notificationDateMinuteKey = "NotificationDateMinuteKey"

class DataPersistence {
    
    static var candidates: [String]? {
        let userDefaults = UserDefaults()
        return userDefaults.stringArray(forKey: candidateKey)
    }
        
    class func add(candidate: String) {
        let userDefaults = UserDefaults()
            
        var candidates = self.candidates ?? []
        candidates.append(candidate)
        userDefaults.set(candidates, forKey: candidateKey)
    }
    
    class func deleteCandidate(at index: Int) {
        let userDefaults = UserDefaults()
        
        var candidates = self.candidates ?? []
        candidates.remove(at: index)
        userDefaults.set(candidates, forKey: candidateKey)
    }
    
    class func setNotificationDate(_ date:(hour: Int?, minute: Int?)) {
        let userDefaults = UserDefaults()
        userDefaults.set(date.hour, forKey: notificationDateHourKey)
        userDefaults.set(date.minute, forKey: notificationDateMinuteKey)
    }    

    static var notificationDate: (hour: Int?, minute: Int?)? {
        let userDefaults = UserDefaults()
        
        // set default notification time
        userDefaults.register(defaults: [
            notificationDateHourKey: 11,
            notificationDateMinuteKey: 20,
        ])
        
        let hour = userDefaults.integer(forKey: notificationDateHourKey)
        let minute = userDefaults.integer(forKey: notificationDateMinuteKey)
        return (hour: hour, minute: minute)
    }
}
