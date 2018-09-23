//
//  FirstViewController.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    let omdbApiKey = "f837a566"
    static var movies: [Movie] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchDataSource = SearchDataSource()
    var movieViewController = MovieViewController()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request = searchBar.text!.replacingOccurrences(of: " ", with: "+").lowercased()
        
        if let url = URL(string: "http://www.omdbapi.com/?apikey=\(omdbApiKey)&t=\(request)") {
            do {
                let contents = try String(contentsOf: url)
                
                FirstViewController.movies.removeAll()
                parseJSON(jsonObj: contents)
                searchTableView.reloadData()
            } catch {
            }
        }
        
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieViewController.setMovie(movie: FirstViewController.movies[indexPath.row])
        tabBarController?.view.addSubview(movieViewController.view)
        movieViewController.view.translatesAutoresizingMaskIntoConstraints = false;
        movieViewController.view.leftAnchor.constraint(equalTo: (tabBarController?.view.leftAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.rightAnchor.constraint(equalTo: (tabBarController?.view.rightAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.bottomAnchor.constraint(equalTo: (tabBarController?.view.bottomAnchor)!, constant: 0.0).isActive = true
        movieViewController.view.topAnchor.constraint(equalTo: (tabBarController?.view.topAnchor)!, constant: 0.0).isActive = true
        
        movieViewController.didMove(toParentViewController: tabBarController)
    }
    
    func parseJSON(jsonObj: String) {
        do {
            let data = jsonObj.data(using: .utf8)
            let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
            
            if let value = json?["Title"] as? String {
                FirstViewController.movies.append(Movie())
                
                FirstViewController.movies[FirstViewController.movies.count - 1].title = value
            }
            if let value = json?["Poster"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].posterURL = value
                FirstViewController.movies[FirstViewController.movies.count - 1].poster = UIImage(data: try! Data(contentsOf: URL(string: value)!))
            }
            if let value = json?["Year"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].year = value
            }
            if let value = json?["Rated"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].rated = value
            }
            if let value = json?["Released"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].released = value
            }
            if let value = json?["Runtime"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].runtime = value
            }
            if let value = json?["Genre"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].genre = value
            }
            if let value = json?["Director"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].director = value
            }
            if let value = json?["Writer"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].writer = value
            }
            if let value = json?["Actors"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].actors = value
            }
            if let value = json?["Plot"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].plot = value
            }
            if let value = json?["Language"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].language = value
            }
            if let value = json?["Awards"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].awards = value
            }
            if let value = json?["imdbRating"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].ratings = value
            }
            if let value = json?["Type"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].type = value
            }
            if let value = json?["DVD"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].dvd = value
            }
            if let value = json?["BoxOffice"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].boxOffice = value
            }
            if let value = json?["Production"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].production = value
            }
            if let value = json?["Website"] as? String {
                FirstViewController.movies[FirstViewController.movies.count - 1].website = value
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        searchTableView.delegate = self
        searchTableView.dataSource = searchDataSource
        searchTableView.tableFooterView = UIView(frame: .zero)
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false;
        searchTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        searchTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        searchTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65.0).isActive = true
        
        tabBarController?.addChildViewController(movieViewController)
        movieViewController.view.frame = CGRect(x: 0, y: 0, width: (tabBarController?.view.frame.width)!, height: (tabBarController?.view.frame.height)!)
        movieViewController.view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
