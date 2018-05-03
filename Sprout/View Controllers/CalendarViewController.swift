//
//  CalendarViewController.swift
//  CalendarWithCustomCell
//
//  Created by Kainoa Palama on 4/17/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
//Leap year function for numberOfDaysInMonth
//Add background color to cell to show record exists

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    // MARK: - Outlets
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    
    // MARK: - LifeCycle Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func setCurrentMonthDays() {
        
        guard let plantType = plantType else { return }
        
        self.currentMonthDays = DayController.shared.fetchDaysForMonth(currentMonth: currentMonthIndex, currentYear: currentYear, lastDay: numberOfDaysInMonth[currentMonthIndex - 1], plantType: plantType)
    }
    
    // MARK: - Helper Functions
    
    func getFirstWeekDay() -> Int {
        print("getFirstWeekDay: \(currentYear) \(currentMonthIndex)")
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        prevButton.isEnabled = true
        currentMonthIndex += 1
        if currentMonthIndex > 12 {
            currentMonthIndex = 1
            currentYear += 1
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        calendarCollectionView.reloadData()
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
        setCurrentMonthDays()
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
        
        calendarCollectionView.reloadData()
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
        setCurrentMonthDays()
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
        if indexPath.item < firstWeekDayOfMonth - 1, firstWeekDayOfMonth > 1 {
            cell.isHidden = true
        } else {
            
            let day = currentMonthDays[indexPath.row - (firstWeekDayOfMonth - 1)]
            
            cell.day = day
            let calcDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.dateLabel.text = "\(calcDate)"
            if currentMonthIndex < presentMonthIndex && currentYear <= presentYear {
                cell.isUserInteractionEnabled = true
                cell.dateLabel.textColor = UIColor.lightGray
            } else if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                
                cell.isUserInteractionEnabled = true
                cell.dateLabel.textColor = UIColor.lightGray
                
            } else {
                cell.isUserInteractionEnabled = true
                cell.dateLabel.textColor=UIColor.black
            }
            let plantRecord = cell.day?.plantRecord
            if plantRecord != nil {
                cell.backgroundColor = UIColor(red: 4.0/255.0, green: 149.0/255.0, blue: 255.0/255.0, alpha: 0.5)
                
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell else {return}
        let plantRecord = cell.day?.plantRecord
        
        if plantRecord != nil && currentMonthIndex <= presentMonthIndex && currentYear <= presentYear {
            performSegue(withIdentifier: "toPlantRecord", sender: cell)
        } else if plantRecord != nil && indexPath.item <= todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
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
}

//Extentions

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
