//
//  AddTaskViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

protocol namendateDelegate: AnyObject
{
    func getData(name:String, date:String)
}

class AddTaskViewController: UIViewController {
    
    weak var delegate: namendateDelegate?
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var dateTf: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTf.text! = "Almulla Group"
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm a"
        dateTf.text! = "\(formatter.string(from: currentDateTime))"
        dateTf.addTarget(self, action: #selector(dateAction), for: .touchDown)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTf.text! = LocalizationProvider.Screen_TaskName
        dateTf.text! = LocalizationProvider.Screen_Dateandtime
        saveBtn.setTitle(LocalizationProvider.Screen_Save, for: .normal)
        clearBtn.setTitle(LocalizationProvider.Screen_Clear, for: .normal)
    }
    
    @objc func dateAction(textField: UITextField) {
        print("date")
        //        pickerView.isHidden = false
        // date picker setup
        let datePickerView:UIDatePicker = UIDatePicker()
        
        // choose the mode you want
        // other options are: DateAndTime, Time, CountDownTimer
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        // choose your locale or leave the default (system)
        //datePickerView.locale = NSLocale.init(localeIdentifier: "it_IT")
        
        datePickerView.addTarget(self, action: #selector(onDatePickerValueChanged), for: .valueChanged)
        dateTf.inputView = datePickerView
        
        // datepicker toolbar setup
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePickerPressed))
        
        // if you remove the space element, the "done" button will be left aligned
        // you can add more items if you want
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        dateTf.inputAccessoryView = toolBar
        
//        self.view.addSubview(dateTf)
        
    }
    
    // the formatter should be "compliant" to the UIDatePickerMode selected below
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        // customize the locale for the formatter if you want
        //formatter.locale = NSLocale(localeIdentifier: "it_IT")
        formatter.dateFormat = "dd/MM/yyyy HH:mm a"
        return formatter
    }
    
    
    @objc func doneDatePickerPressed(){
        self.view.endEditing(true)
    }
    
    @objc func onDatePickerValueChanged(datePicker: UIDatePicker) {
        self.dateTf.text = dateFormatter.string(from: datePicker.date)
    }
    
    
    //MARK:- BUTTONCLIKD
    @IBAction func backBtnCliked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnCliked(_ sender: Any)
    {
        if (nameTf.text != "" && dateTf.text != "")
        {
          delegate?.getData(name: nameTf.text!, date: dateTf.text!)
          self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func clearBtnCLiked(_ sender: Any){
        nameTf.text = ""
        dateTf.text = ""
    }
    
   
}
