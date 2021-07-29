import UIKit

private let candidateKey = "CandidateKey"

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
}
