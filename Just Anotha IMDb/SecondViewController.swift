//
//  SecondViewController.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate {
    
    static var movies: [Movie] = []

    @IBOutlet weak var bookmarked1: UILabel!
    @IBOutlet weak var bookmarked2: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var bookmarkedTableView: UITableView!
    
    let bookmarkedDataSource = BookmarkedDataSource()
    var movieViewController = MovieViewController()
    
    var leftAnchor: NSLayoutConstraint!, topAnchor: NSLayoutConstraint!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieViewController.setMovie(movie: SecondViewController.movies[indexPath.row])
        tabBarController?.view.addSubview(movieViewController.view)
        movieViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        movieViewController.view.leftAnchor.constraint(equalTo: (tabBarController?.view.leftAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.rightAnchor.constraint(equalTo: (tabBarController?.view.rightAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.bottomAnchor.constraint(equalTo: (tabBarController?.view.bottomAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.topAnchor.constraint(equalTo: (tabBarController?.view.topAnchor)!, constant: 0.0).isActive = true
        
        movieViewController.didMove(toParentViewController: tabBarController)
        
    }
    
    func parseJSON(jsonm: String) {
        do {
            let data = jsonm.data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
            
            if let value = json?["Title"] as? String {
                SecondViewController.movies.append(Movie())
                
                SecondViewController.movies[SecondViewController.movies.count - 1].title = value
            }
            if let value = json?["Poster"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].posterURL = value
                SecondViewController.movies[SecondViewController.movies.count - 1].poster = UIImage(data: try! Data(contentsOf: URL(string: value)!))
            }
            if let value = json?["Year"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].year = value
            }
            if let value = json?["Rated"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].rated = value
            }
            if let value = json?["Released"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].released = value
            }
            if let value = json?["Runtime"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].runtime = value
            }
            if let value = json?["Genre"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].genre = value
            }
            if let value = json?["Director"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].director = value
            }
            if let value = json?["Writer"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].writer = value
            }
            if let value = json?["Actors"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].actors = value
            }
            if let value = json?["Plot"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].plot = value
            }
            if let value = json?["Language"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].language = value
            }
            if let value = json?["Awards"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].awards = value
            }
            if let value = json?["imdbRating"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].ratings = value
            }
            if let value = json?["Type"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].type = value
            }
            if let value = json?["DVD"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].dvd = value
            }
            if let value = json?["BoxOffice"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].boxOffice = value
            }
            if let value = json?["Production"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].production = value
            }
            if let value = json?["Website"] as? String {
                SecondViewController.movies[SecondViewController.movies.count - 1].website = value
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
    
    func loadJSON() {
        SecondViewController.movies.removeAll()
        
        let dictionary = UserDefaults.standard.dictionaryRepresentation()
        for pair in dictionary {
            if pair.key.hasPrefix("OMDb") {
                parseJSON(jsonm: pair.value as! String)
            }
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            leftAnchor.constant = CGFloat(568 / 2 - 15)
            topAnchor.constant = CGFloat(320 / 2 - 15)
        } else {
            leftAnchor.constant = CGFloat(320 / 2 - 15)
            topAnchor.constant = CGFloat(568 / 2 - 15)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkedTableView.delegate = self
        
        bookmarkedTableView.tableFooterView = UIView(frame: .zero)
        
        bookmarkedTableView.translatesAutoresizingMaskIntoConstraints = false;
        bookmarkedTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        bookmarkedTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        bookmarkedTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        bookmarkedTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65.0).isActive = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.removeConstraints(indicator.constraints)
        
        leftAnchor = indicator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(320 / 2 - 15))
        topAnchor = indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(568 / 2 - 15))
        
        leftAnchor.isActive = true
        topAnchor.isActive = true
        
        tabBarController?.addChildViewController(movieViewController)
        movieViewController.view.frame = CGRect(x: 0, y: 0, width: (tabBarController?.view.frame.width)!, height: (tabBarController?.view.frame.height)!)
        movieViewController.view.backgroundColor = .white
        
        bookmarked1.isHidden = true
        bookmarked2.isHidden = true
        indicator.startAnimating()
        OperationQueue().addOperation {
            self.bookmarkedTableView.isHidden = true
            self.loadJSON()
            self.bookmarkedTableView.dataSource = self.bookmarkedDataSource
            self.bookmarkedTableView.reloadData()
            
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            self.bookmarked1.isHidden = false
            self.bookmarked2.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
