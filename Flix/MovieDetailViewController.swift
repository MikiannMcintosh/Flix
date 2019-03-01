//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Mikiann Mcintosh on 2/28/19.
//  Copyright © 2019 Mikiann McIntosh. All rights reserved.
//

import UIKit
import AlamofireImage


class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var backDropView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL (string: baseURL + posterPath)
        
        posterView.af_setImage(withURL: posterURL!)
        
        let backdropPath = movie["backdrop_path"] as! String
        //Setting the backdrop image view to this URL
       let backdropURL = URL(string: "https://image.tmdb.org/t/p/w1280" + backdropPath)
        
        backDropView.af_setImage(withURL: backdropURL!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
