//
//  TaskVc.swift
//  TaskManager
//
//  Created by Hamas Mahroof on 23/04/2024.
//

import UIKit
import EventKit
import CalendarKit
import EventKit
import EventKitUI


class TaskVc: UIViewController, EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
           }
    
    let excludedEvents = [
        "Good Friday",
        "Easter",
        "April Fools’ Day",
        "Eid al-Fitr",
        "Tax Day",
        "Earth Day",
        "Passover",
        "Cinco de Mayo",
        "Orthodox Easter",
        "Mother’s Day",
        "Memorial Day",
        "Flag Day",
        "David Taylor’s 26th Birthday",
        "Father’s Day",
        "Eid al-Adha",
        "Juneteenth",
        "John Appleseed’s 44th Birthday"
    ]


    @IBOutlet weak var tableview: UITableView!
    private var ekEventStore = EKEventStore()

    var events = [EventDescriptor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initModel()

    }
    
    // MARK: initialize model
    
    private func initModel(){
        
        // connect cell class with tableview
        tableview.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        let ev = events(from: getDateOfLastMonth(from: Date())!, to: getDateOfNextMonth(from: Date())!)
        
        ev.forEach { e in
            print(e.text)
           
        }
        self.events = ev
        self.tableview.reloadData()
    }
    

    // fetch all tasks
    func events(from startDate: Date, to endDate: Date) -> [EventDescriptor] {
        

        let predicate = ekEventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
         let eventKitEvents = ekEventStore.events(matching: predicate)

         // Filter events to skip the excluded ones
         let filteredEvents = eventKitEvents.filter { event in
             !excludedEvents.contains(event.title)
         }

         // Assuming EKWrapper is a custom wrapper that converts EKEvent to your EventDescriptor
         let calendarKitEvents = filteredEvents.map(EKWrapper.init)

         return calendarKitEvents
    }
    

    func getDateOfLastMonth(from date: Date) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -1, to: date)
    }
    
    func getDateOfNextMonth(from date: Date) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: 2, to: date)
    }
}

extension TaskVc : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let event = events[indexPath.row]
        
        cell.nameLabel.text = event.text
        cell.timeLabel.text = event.dateInterval.end.toString()
        
        let status = event.dateInterval.end < Date() ? "Done" : "Pending"

        cell.statusLabel.text = status
        
        return cell
    }
    
    
    
}
