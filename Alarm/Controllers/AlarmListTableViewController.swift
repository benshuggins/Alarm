//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by User on 1/28/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit


protocol AlarmTableViewCellDelegate: class{
    func alarmWasToggled(sender: SwitchTableViewCell)
}

class AlarmListTableViewController: UITableViewController {
    
    func alarmsWasToggled(sender: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(for: alarm)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.delegate = self
     tableView.dataSource = self
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell

        cell?.alarm = AlarmController.shared.alarms[indexPath.row]
        
        //step 5
        
        cell?.alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.delegate = self  //as! SwitchTableViewCellDelegate
        
        return cell ?? UITableViewCell()
    }
   

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmVC"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let alarm = AlarmController.shared.alarms[indexPath.row]
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            destinationVC?.alarm = alarm
        }
    }
   

}


extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    
    
    func switchValueChanged(_ cell: SwitchTableViewCell, selected: Bool) {
        guard let alarm = cell.alarm,
            let cellIndexPath = tableView.indexPath(for: cell) else { return }
        tableView.beginUpdates()
        alarm.enabled = selected
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    
}
extension AlarmListTableViewController: AlarmScheduler {
    func scheduleNotification(for alarm: Alarm) {
        tableView.reloadData()
    }
    
    
}



    
    
    

