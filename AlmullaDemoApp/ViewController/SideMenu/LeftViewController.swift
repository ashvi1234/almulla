//
//  LeftViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case ChangeSetting = 0
    case Logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol,changeLangDelegate {
    
    func changeData(lang: String) {
        print(lang)
        leftTableView.reloadData()
    }
    
    @IBOutlet weak var leftTableView: UITableView!
    
    var menus = ["Change Language", "Logout"]
    var ChngeLangViewController: UIViewController!
    var ViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftTableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let ChngeLangViewController = storyboard.instantiateViewController(withIdentifier: "ChngeLangViewController") as! ChngeLangViewController
////        self.ChngeLangViewController = UINavigationController(rootViewController: ChngeLangViewController)
//        self.navigationController?.pushViewController(ChngeLangViewController, animated: true)

        let ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.ViewController = UINavigationController(rootViewController: ViewController)

        self.leftTableView.registerCellClass(BaseTableViewCell.self)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .ChangeSetting:
//            self.slideMenuController()?.changeMainViewController(self.ChngeLangViewController, close: true)
            let ChngeLangViewController = storyboard?.instantiateViewController(withIdentifier: "ChngeLangViewController") as! ChngeLangViewController
             ChngeLangViewController.langDelegate = self
             self.navigationController?.pushViewController(ChngeLangViewController, animated: true)
        case .Logout:
            self.slideMenuController()?.changeMainViewController(self.ViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .ChangeSetting, .Logout:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.leftTableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .ChangeSetting:
                let cell = BaseTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[0])
                cell.textLabel?.text = LocalizationProvider.Screen_changeLang
                return cell
            case .Logout:
                let cell = BaseTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[1])
                cell.textLabel?.text = LocalizationProvider.Screen_logout
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

