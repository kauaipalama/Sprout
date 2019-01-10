//
//  CalendarViewController.swift
//  CalendarWithCustomCell
//
//  Created by Kainoa Palama on 4/17/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//Leap year function for numberOfDaysInMonth. ADD
//Notes at the bottom of the calendarView that persist with the coreData model. General notes for the month. Save to coreData and fetch for month.
//Fix the cells of the collection view from duplicating the image on frames that do not contain plantRecords. Seems to be an indexing issue. Happens when going back and forth between months. FIX (HIDDEN RIGHT NOW)
//ALSO. Major bug only reproducable when using "old" data. Error: Index out of range. Happens when loading "days" in cellForRowAt
//REDUCE CODE by following MVC principles. Move properties into a model file and functions into a controller file to increase modularity and readabilty.

//LOOKS good. Still needs work
import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Grow Log"
        setCalendar()
        
        view.backgroundColor = SproutTheme.current.backgroundColor
        headerView.backgroundColor = SproutTheme.current.backgroundColor
        monthLabel.textColor = SproutTheme.current.textColor
        print(self.view.frame.origin.y)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    // MARK: - Calendar Setup
    
    func setCalendar() {
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        presentMonthIndex = currentMonthIndex
        presentYear = currentYear
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        
        setCurrentMonthDays()
    }
    
    // MARK: - Helper Functions
    
    func setCurrentMonthDays() {
        
        guard let plantType = plantType else { return }
        
        self.currentMonthDays = DayController.shared.fetchDaysForMonth(currentMonth: currentMonthIndex, currentYear: currentYear, lastDay: numberOfDaysInMonth[currentMonthIndex - 1], plantType: plantType)
    }
    
    func getFirstWeekDay() -> Int {
        print("getFirstWeekDay: \(currentYear) \(currentMonthIndex)")
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
    
    // MARK: - CollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    // MARK: - CollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.clear
        cell.layer.cornerRadius = 8
        
        if indexPath.item < firstWeekDayOfMonth - 1, firstWeekDayOfMonth > 1 {
            cell.isHidden = true
        } else {
            //Here is the MAJOR BUG occurance due to index out of range (day). Possible indexing issue.
            let day = currentMonthDays[indexPath.row - (firstWeekDayOfMonth - 1)]
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            
            cell.day = day
            cell.dateLabel.text = "\(calcDate)"
            cell.isHidden = false
            cell.dateLabel.textColor = SproutTheme.current.textColor
            
            let plantRecord = cell.day?.plantRecord
            if plantRecord != nil {
                cell.dateLabel.textColor = UIColor.darkText
                switch plantRecord?.plantHealth {
                case 1:
                    cell.backgroundColor = SproutTheme.current.health1Color
                case 2:
                    cell.backgroundColor = SproutTheme.current.health2Color
                case 3:
                    cell.backgroundColor = SproutTheme.current.health3Color
                case 4:
                    cell.backgroundColor = SproutTheme.current.health4Color
                case 5:
                    cell.backgroundColor = SproutTheme.current.health5Color
                default:
                     cell.backgroundColor = UIColor.clear
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else {return}
        let plantRecord = cell.day?.plantRecord
        
        if plantRecord != nil {
            performSegue(withIdentifier: "toPlantRecord", sender: cell)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlantRecord"{
            guard let cell = sender as? CalendarCollectionViewCell else {return}
            let day = cell.day
            guard let destinationVC = segue.destination as? PlantRecordViewController else {return}
            destinationVC.day = day
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        prevButton.isEnabled = true
        currentMonthIndex += 1
        if currentMonthIndex > 12 {
            currentMonthIndex = 1
            currentYear += 1
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
        setCurrentMonthDays()
        calendarCollectionView.reloadData()
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        if currentYear == startDateComponents.year && currentMonthIndex == startDateComponents.month {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
            currentMonthIndex -= 1
        }
        if currentMonthIndex < 1 {
            currentMonthIndex = 12
            currentYear -= 1
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
        setCurrentMonthDays()
        calendarCollectionView.reloadData()
    }
    
    // MARK: - Properties
    
    var plantType: PlantType?
    
    var monthsArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear = 0
    var numberOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    var currentMonthDays: [Day] = []
    
    let startDateComponents = DateComponents(calendar: Calendar.current, year: 2018, month: 4)
}

// MARK: - Extentions

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}
