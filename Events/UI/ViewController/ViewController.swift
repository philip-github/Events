//
//  ViewController.swift
//  Events
//
//  Created by Philip Twal on 5/23/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewControllerVm = ViewControllerVM()
    var eventInSection : Dictionary<String,[Event]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerVm.localDataApiCall { (events, error) in
            if error == nil && events != nil {
                self.eventInSection = self.viewControllerVm.generateSortedSections(events: events!)
//                self.viewControllerVm.identifyConflict(sections: self.viewControllerVm.sectionList, events: self.eventInSection!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewControllerVm.sectionList != []{
            let date = viewControllerVm.sectionList[section]
            return eventInSection![date]!.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomTableViewCell else {return UITableViewCell()}
        
        let mySection = viewControllerVm.sectionList[indexPath.section]
       
        let data = eventInSection?[mySection]?[indexPath.row]
        
        cell.populate(eventLabel: LabelTitle.event.rawValue + "\(data?.title ?? "")", startLabel: LabelTitle.start.rawValue + "\( data?.start ?? "")", endLabel: LabelTitle.end.rawValue + "\(data?.end ?? "")")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let events = eventInSection else {return 0}
        return events.keys.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let sectionList = viewControllerVm.sectionList
        
        if sectionList != [] {
            let myHeaderView = UIView()
            let myTitle = UILabel()
            myHeaderView.backgroundColor = .lightGray
            myTitle.frame = CGRect(x: 20, y: 15, width: 400, height: 25)
            myTitle.font = .boldSystemFont(ofSize: 20)
            myTitle.text = sectionList[section]
            myHeaderView.addSubview(myTitle)
            return myHeaderView
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        let sectionList = viewControllerVm.sectionList
        if sectionList != []{
            return 50
        }
        return 0
    }
    
}
