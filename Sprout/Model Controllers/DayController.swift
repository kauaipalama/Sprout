//
//  DayController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/24/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//
//Which functions should be saved to persistant store

import Foundation
import CoreData

class DayController {
    
    // MARK: - CRUD
    
    func createCalendarStartingDay() -> Day? {
        let startingDay: Day
        
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 4
        dateComponents.day = 1
        
        let userCalendar = Calendar.current
        guard let startingDate = userCalendar.date(from: dateComponents) else {return nil}
        startingDay = Day(date: startingDate, plantRecord: nil, plantType: nil)
        
        return startingDay
    }
    
    func createDaysForTenYearsFor(plantType: PlantType) {
        
        guard let startingDay = createCalendarStartingDay() else {return}
        for i in 0...3650 {
            guard let date = Calendar.current.date(byAdding: .day, value: i, to: startingDay.date!) else {continue}
            let day = Day(date: date, plantRecord: nil, plantType: plantType)
            plantType.addToDays(day)
        }
    }
    
    func fetchDaysForMonth(currentMonth: Int, currentYear: Int, lastDay: Int, plantType: PlantType) -> [Day] {
        
        let firstDayComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: currentYear, month: currentMonth, day: 1, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        
        let lastDayComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: currentYear, month: currentMonth, day: lastDay, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        
        let firstDayOfMonth = Calendar.current.date(from: firstDayComponents)
        let lastDayOfMonth = Calendar.current.date(from: lastDayComponents)
        
        guard let startDate = firstDayOfMonth,
            let endDate = lastDayOfMonth
            else {return []}
        
        let predicate1 = NSPredicate(format: "date >= %@", startDate as NSDate)
        let predicate2 = NSPredicate(format: "date <= %@", endDate as NSDate)
        let predicate3 = NSPredicate(format: "plantType == %@", plantType)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2, predicate3])
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let moc = CoreDataStack.context
        let daysFetch = NSFetchRequest<Day>(entityName: "Day")
        daysFetch.predicate = compoundPredicate
        daysFetch.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchedDays = try moc.fetch(daysFetch)
            return fetchedDays
        } catch {
            print("Failed to fetch days for month: \(error)")
            return []
        }
    }
    
    // MARK: - Properties
    
    static let shared = DayController()
    
    var day: Day?
    var calendarDays: [Day] = []
}


