//
//  MovieDataSource.swift
//  Just Anotha IMDb
//
//  Created by для интернета on 23.09.18.
//  Copyright © 2018 для интернета. All rights reserved.
//

import Foundation
import UIKit

class MovieDataSource: NSObject, UITableViewDataSource {
    
    var movie: Movie!
    
    func setMovie(movie: Movie) {
        self.movie = movie
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "actionCell")
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = movie.title
        case 1:
            cell.textLabel!.textColor = .gray
            cell.textLabel!.numberOfLines = 2
            cell.textLabel!.text = "\(movie.runtime ?? "") - \(movie.genre ?? "") - \(movie.released ?? "")"
            cell.textLabel!.sizeToFit()
        case 2:
            cell.textLabel!.text = "Rating: \(movie.ratings ?? "")/10"
        case 3:
            cell.textLabel!.text = "Director: \(movie.director ?? "")"
        case 4:
            cell.textLabel!.numberOfLines = 2
            cell.textLabel!.text = "Writers: \(movie.writer ?? "")"
            cell.textLabel!.sizeToFit()
        case 5:
            cell.textLabel!.text = "Type: \(movie.type ?? "")"
        case 6:
            cell.textLabel!.text = "Plot:"
        case 7:
            cell.textLabel!.textColor = .gray
            cell.textLabel!.numberOfLines = 4
            cell.textLabel!.text = movie.plot
            cell.textLabel!.sizeToFit()
        case 8:
            let poster = UIImageView(frame: CGRect(x: 0, y: 0, width: 320, height: 320));
            poster.image = movie.poster
            cell.contentView.addSubview(poster)
            
            poster.translatesAutoresizingMaskIntoConstraints = false
            poster.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 0.0).isActive = true
            poster.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: 0.0).isActive = true
            poster.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0.0).isActive = true
            poster.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0.0).isActive = true
        case 9:
            cell.textLabel!.numberOfLines = 3
            cell.textLabel!.text = "Actors: \(movie.actors ?? "")"
            cell.textLabel!.sizeToFit()
        case 10:
            cell.textLabel!.text = "Language: \(movie.language ?? "")"
        case 11:
            cell.textLabel!.numberOfLines = 2
            cell.textLabel!.text = "Awards: \(movie.awards ?? "")"
            cell.textLabel!.sizeToFit()
        case 12:
            cell.textLabel!.text = "DVD: \(movie.dvd ?? "")"
        case 13:
            cell.textLabel!.text = "Rated: \(movie.rated ?? "")"
        case 14:
            cell.textLabel!.text = "Production: \(movie.production ?? "")"
        case 15:
            cell.textLabel!.numberOfLines = 2
            cell.textLabel!.text = "Website: \(movie.website ?? "")"
            cell.textLabel!.sizeToFit()
        default:
            cell.textLabel!.text = "Dummy"
        }
        
        return cell
    }
}
