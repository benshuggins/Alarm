//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by User on 1/28/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    var alarm: Alarm?{
        didSet{
            loadViewIfNeeded()
            self.updateViews()
            
        }
    }
    
    var alarmIsOn: Bool = true
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTextField: UITextField!
    @IBOutlet weak var alarmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        
   
    }
    
    func updateViews(){
        
        guard let alarm = alarm else {return}
        alarmIsOn = alarm.enabled
        alarmDatePicker.date = alarm.fireDate
        alarmTextField.text = alarm.name
        setUpAlarmButton()

    }
    func setUpAlarmButton(){
        
        switch alarmIsOn {
        case true:
            alarmButton.backgroundColor = UIColor.green
            alarmButton.setTitle("ON", for: .normal)
        case false:
            alarmButton.backgroundColor = UIColor.gray
            alarmButton.setTitle("Off", for: .normal)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    
        guard let title = alarmTextField.text else {return}
        guard title != "" else {return}
        
        if let alarm = alarm{
            AlarmController.shared.update(alarm: alarm, fireDate: alarmDatePicker.date, name: title, enabled: alarmIsOn)
        } else{
            AlarmController.shared.addAlarm(fireDate: alarmDatePicker.date, name: title, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
        }
   
    
    }
    
    


    
    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }

    


