import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var components = DateComponents()
        components.hour = DataPersistence.notificationDate?.hour
        components.minute = DataPersistence.notificationDate?.minute
        datePicker.setDate(NSCalendar.current.date(from: components)!, animated: true)
    }
    
    @IBAction func handleDateSelection(_ sender: UIDatePicker) {
        
        let components = sender.calendar.dateComponents([.hour, .minute], from: sender.date)
        DataPersistence.setNotificationDate((hour: components.hour, minute: components.minute))
        
        let content = UNMutableNotificationContent()
        content.title = "Pick a Restaurant!"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        date.hour = components.hour
        date.minute = components.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true) // alert every day
    
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
        })
    }
}
