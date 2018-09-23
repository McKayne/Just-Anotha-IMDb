//
//  SearchDataSource.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import Foundation
import UIKit

class SearchDataSource: NSObject, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if FirstViewController.movies.count == 0 {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
        return FirstViewController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "searchCell")
        cell.textLabel?.textAlignment = .center
        
        let poster = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100));
        poster.image = FirstViewController.movies[indexPath.row].poster
        cell.contentView.addSubview(poster)
        
        let title = UILabel(frame: CGRect(x: 100, y: 0, width: 220, height: 30))
        title.text = FirstViewController.movies[indexPath.row].title
        cell.contentView.addSubview(title)
        
        let plot = UILabel(frame: CGRect(x: 100, y: 30, width: 220, height: 70))
        plot.textColor = .gray
        plot.numberOfLines = 3
        plot.text = FirstViewController.movies[indexPath.row].plot
        plot.sizeToFit()
        cell.contentView.addSubview(plot)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 100.0).isActive = true
        title.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: 0.0).isActive = true
        title.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -70.0).isActive = true
        title.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0.0).isActive = true
        
        plot.translatesAutoresizingMaskIntoConstraints = false
        plot.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 100.0).isActive = true
        plot.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: 0.0).isActive = true
        plot.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0.0).isActive = true
        plot.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 30.0).isActive = true
        
        return cell
    }
}
