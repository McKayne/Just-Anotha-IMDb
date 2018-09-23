//
//  Movie.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var title: String!
    var year: String!
    var rated: String!
    var released: String!
    var runtime: String!
    var genre: String!
    var director: String!
    var writer: String!
    var actors: String!
    var plot: String!
    var language: String!
    var awards: String!
    var posterURL: String!, poster: UIImage!
    var ratings: String!
    var type: String!
    var dvd: String!
    var boxOffice: String!
    var production: String!
    var website: String!
    
    func emailShare(controller: UIViewController, view: UIView) {
        let activityViewController = UIActivityViewController(activityItems: [poster], applicationActivities:nil)
        activityViewController.excludedActivityTypes = []
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.size.width / 2, y: view.bounds.size.height / 4, width: 0, height: 0)
        controller.present(activityViewController, animated: true, completion:nil)
    }
    
    func jsonSerialize() -> String {
        var dictionary = [String : String]()
        dictionary["Title"] = title
        dictionary["Year"] = year
        dictionary["Rated"] = rated
        dictionary["Released"] = released
        dictionary["Runtime"] = runtime
        dictionary["Genre"] = genre
        dictionary["Director"] = director
        dictionary["Writer"] = writer
        dictionary["Actors"] = actors
        dictionary["Plot"] = plot
        dictionary["Language"] = language
        dictionary["Awards"] = awards
        dictionary["Poster"] = posterURL
        dictionary["imdbRating"] = ratings
        dictionary["Type"] = type
        dictionary["DVD"] = dvd
        dictionary["BoxOffice"] = boxOffice
        dictionary["Production"] = production
        dictionary["Website"] = website
        
        if let json = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            return String(data: json, encoding: .utf8)!
        }
        return ""
    }
}
