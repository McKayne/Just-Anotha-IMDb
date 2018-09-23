//
//  MovieViewController.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UIActionSheetDelegate {
    
    var movie: Movie!
    
    let navigationBar = UINavigationBar()
    let barTitle = UINavigationItem()
    
    let backButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(moveToBookmarked(sender:)))
    let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePopup(sender:)))
    
    var actionSheet: UIActionSheet!
    
    let movieTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 400))
    let movieDataSource = MovieDataSource()
    
    func setMovie(movie: Movie) {
        self.movie = movie
        movieDataSource.setMovie(movie: movie)
        movieTableView.reloadData()
        barTitle.title = movie.title
    }
    
    func sharePopup(sender: UIBarButtonItem) {
        if UserDefaults.standard.string(forKey: "OMDb \(movie.title ?? "" )") != nil {
            actionSheet = UIActionSheet(title: "Sharing", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Twitter share", "Facebook share", "Email share", "Remove bookmark")
        } else {
            actionSheet = UIActionSheet(title: "Sharing", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Twitter share", "Facebook share", "Email share", "Add bookmark")
        }
        
        actionSheet.delegate = self
        actionSheet.show(in: self.view)
    }
    
    func moveToBookmarked(sender: UIBarButtonItem) {
        self.view.removeFromSuperview()
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        var bookmarkedTableView: UITableView?
        if tabBarController?.childViewControllers[1] is SecondViewController {
            bookmarkedTableView = (tabBarController?.childViewControllers[1] as! SecondViewController).bookmarkedTableView
        } else {
            bookmarkedTableView = (tabBarController?.childViewControllers[2] as! SecondViewController).bookmarkedTableView
        }
        
        switch buttonIndex {
        case 3:
            movie.emailShare(controller: self, view: self.view)
        case 4:
            if UserDefaults.standard.string(forKey: "OMDb \(movie.title ?? "" )") != nil {
                UserDefaults.standard.removeObject(forKey: "OMDb \(movie.title ?? "" )")
                
                var svc: SecondViewController
                if tabBarController?.childViewControllers[1] is SecondViewController {
                    svc = tabBarController?.childViewControllers[1] as! SecondViewController
                } else {
                    svc = tabBarController?.childViewControllers[2] as! SecondViewController
                }
                svc.loadJSON()
                if bookmarkedTableView != nil {
                    bookmarkedTableView!.reloadData()
                }
                
            } else {
                UserDefaults.standard.set(movie.jsonSerialize(), forKey: "OMDb \(movie.title ?? "" )")
                
                var svc: SecondViewController
                if tabBarController?.childViewControllers[1] is SecondViewController {
                    svc = tabBarController?.childViewControllers[1] as! SecondViewController
                } else {
                    svc = tabBarController?.childViewControllers[2] as! SecondViewController
                }
                svc.loadJSON()
                if bookmarkedTableView != nil {
                    bookmarkedTableView!.reloadData()
                }
            }
        default:
            print("Dummy")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1, 4, 11, 15:
            return 60.0
        case 9:
            return 90.0
        case 7:
            return 100.0
        case 8:
            return 320.0
        default:
            return 30.0
        }
    }
    
    override func viewDidLoad() {
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 65)
        navigationBar.isTranslucent = false
        
        
        barTitle.leftBarButtonItem = backButton
        barTitle.rightBarButtonItem = shareButton
        navigationBar.pushItem(barTitle, animated: false)
        
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0).isActive = true
        
        movieTableView.delegate = self
        movieTableView.dataSource = movieDataSource
        movieTableView.separatorStyle = .none
        movieTableView.allowsSelection = false
        movieTableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(movieTableView)
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        movieTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        movieTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        movieTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65.0).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
