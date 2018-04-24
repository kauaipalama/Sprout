//
//  CalendarViewController.swift
//  CalendarWithCustomCell
//
//  Created by Kainoa Palama on 4/17/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//TODO:
// Make a day which allows the user to select day on calendar in order to fetch latest plantRecord when detailsButtonTapped
//

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
    
    // MARK: - Outlets
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
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

    }
    
    // MARK: - Helper Functions
    
    func getFirstWeekDay() -> Int {
        print("getFirstWeekDay: \(currentYear) \(currentMonthIndex)")
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 7 ? 1 : day
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        currentMonthIndex += 1
        if currentMonthIndex > 12 {
            currentMonthIndex = 1
            currentYear += 1
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        calendarCollectionView.reloadData()
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        currentMonthIndex -= 1
        if currentMonthIndex < 1 {
            currentMonthIndex = 12
            currentYear -= 1
        }
        
        firstWeekDayOfMonth = getFirstWeekDay()
        
        calendarCollectionView.reloadData()
        monthLabel.text = "\(monthsArray[currentMonthIndex - 1]) \(currentYear)"
    }
    @IBAction func detailButtonTapped(_ sender: Any) {
        print("detailButtonTapped")
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
        return numberOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCollectionViewCell
        cell.backgroundColor = UIColor.clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden = false
            cell.dateLabel.text = "\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled = false
                cell.dateLabel.textColor = UIColor.lightGray
                
            } else {
                cell.isUserInteractionEnabled = true
                cell.dateLabel.textColor=UIColor.black
            }
        }
        return cell
    }
    
    //Implement For Highlighting Cells
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
