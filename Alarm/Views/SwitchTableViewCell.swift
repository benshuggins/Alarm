//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by User on 1/28/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchValueChanged(_ cell: SwitchTableViewCell, selected: Bool)
}

class SwitchTableViewCell: UITableViewCell {

 // Basically a landing pad
    var alarm: Alarm? {
    didSet {
        updateViews()
    }
    
    }
    //step 2
   
    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var alarmName: UILabel!

    @IBOutlet weak var alarmTime: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews(){
        guard let alarm = alarm else {return}
        
        alarmName.text = alarm.name
        alarmTime.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
        
        backgroundColor = alarm.enabled ? .yellow : .white
    }


   // step 3 
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        delegate?.switchValueChanged(self, selected: alarmSwitch.isOn)
       
    }
    
}

