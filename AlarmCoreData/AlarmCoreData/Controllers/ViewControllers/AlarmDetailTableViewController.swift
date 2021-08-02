//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Natalie Hall on 7/29/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    var defaultColor: UIColor = .systemTeal
    
    // MARK: - Helpers
    func updateView() {
        guard let alarm = alarm else { return }
        alarmFireDatePicker.date = alarm.fireDate!
        alarmTitleTextField.text = alarm.title
        isAlarmOn = alarm.isEnabled
        
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = defaultColor
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .systemPink
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }

    // MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
            isAlarmOn = alarm.isEnabled
        } else {
            isAlarmOn = !isAlarmOn
        }
        designIsEnabledButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text, !title.isEmpty else { return }
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, newTitle: title, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        } else {
            AlarmController.shared.createAlarm(withTitle: title, on: isAlarmOn, and: alarmFireDatePicker.date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
} // End of Class
