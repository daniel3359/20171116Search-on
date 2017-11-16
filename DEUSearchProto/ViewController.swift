//
//  ViewController.swift
//  DEUSearchProto
//
//  Created by D7703_15 on 2017. 11. 16..
//  Copyright © 2017년 D7703_15. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    //이제 없어지는 기능
    //var searchB: UISearchDisplayController
    let arrayA = ["aa","bb","cc","dd","ee","ff","gg","hh","ii","jj","fg","eg"]
    var searchCon: UISearchController!
    var filteredArray = [String]()
    @IBOutlet weak var tableV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.searchCon = {
            self.searchCon = UISearchController(searchResultsController: nil)
            self.searchCon.searchResultsUpdater = self
            self.searchCon.dimsBackgroundDuringPresentation = false
            self.searchCon.searchBar.sizeToFit()
            tableV.tableHeaderView = self.searchCon.searchBar
        //    return con
        //}()
        
        self.tableV.dataSource = self
        self.tableV.delegate = self
        
        //셀의 식별자 지정 - Reuse
        self.tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Reuse")
        
    }

    //테이블 뷰가 직접 실행하는 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return self.searchCon.isActive ? filteredArray.count : arrayA.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재활용 한 셀을 찾아 온것. ->재사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse", for: indexPath)
        
        cell.textLabel?.text = self.searchCon.isActive ? filteredArray[indexPath.row] : arrayA[indexPath.row]
        return cell
    }
    
    //글자를 한자라도 적으면 실행됨
    func updateSearchResults(for searchController: UISearchController) {
        //print(searchController.searchBar.text!)
        self.filteredArray.removeAll(keepingCapacity: false)
        let predicateA = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let arrF = (arrayA as NSArray).filtered(using: predicateA)
        filteredArray = arrF as! [String]
        self.tableV.reloadData()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["aa","bb","cc","dd","ee","ff","gg","hh","ii","jj","fg","eg"]
    }

}

