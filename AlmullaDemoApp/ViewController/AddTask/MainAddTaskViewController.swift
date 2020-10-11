//
//  MainAddTaskViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 07/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

class MainAddTaskViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,namendateDelegate {
    
    @IBOutlet weak var topView: comntopView!
    @IBOutlet weak var bottomView: comnbottomView!
    @IBOutlet weak var tasktableView: UITableView!
    var nameArray = [String]()
    var dateArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        topView.currentVC = self
        bottomView.currentbottomVC = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
       
    }
    
    //MARK:- TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainAddTaskViewCell
        
        cell.nameLbl.text = nameArray[indexPath.row]
        cell.dateLbl.text = dateArray[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let Delete = "\(LocalizationProvider.Screen_Delete)?"
        let Message = "\(LocalizationProvider.Screen_Areyousureyouwanttodeletethistask)?"
        let Cancel = LocalizationProvider.Screen_Cancel
        let OK = LocalizationProvider.Screen_OK
        
        let alert = UIAlertController(title: Delete, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Cancel, style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: OK, style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            print("Action")
            if (editingStyle == .delete) {
                // handle delete (by removing the data from your array and updating the tableview)
                if let tv=self.tasktableView
                    {
                        self.nameArray.remove(at: indexPath.row)
                        self.dateArray.remove(at: indexPath.row)
                        tv.deleteRows(at: [indexPath], with: .fade)

                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addBtnCliked(_ sender: Any)
    {
        let addTask = storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        addTask.delegate = self
        self.navigationController?.pushViewController(addTask, animated: true)
    }
    
    //MARK:- DelegateMethod
    func getData(name:String, date:String) {
        print(name , date)
        nameArray.append(name)
        dateArray.append(date)
        tasktableView.reloadData()
               
    }
    
  
}


class MainAddTaskViewCell : UITableViewCell{
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
}
