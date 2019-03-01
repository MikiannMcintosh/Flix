//
//  MoviesViewController.swift
//  Flix
//
//  Created by Mikiann Mcintosh on 2/21/19.
//  Copyright © 2019 Mikiann McIntosh. All rights reserved.
//

import UIKit
//This block of code downloads the array of movies and stores it in "self.movies = dataDictionary["results"] as! [[String:Any]]"
import AlamofireImage

//Step 1 add in UITableViewDataSource & UITableViewDelegate -> You want your datasoucre to work w/ the table view
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    

    @IBOutlet weak var TableView: UITableView!
    //variables stored here are called properties
    var movies = [[String:Any]] () //Dictionary w/in an array
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.dataSource = self
        TableView.delegate = self
        // Do any additional setup after loading the view.
     
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                //hey movies I want you to look in that data dictionary and I want you to get our results
                //Needs to be cast as an array of dictionaries with as! [[String:Any]]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.TableView.reloadData()
             
                
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Give me the cell for table
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        //Combines poster url with that path
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)        //swift optionals "?"
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print ("Loading up the details screen")
        
        //First find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = TableView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        
        
        
        //Then pass the selected movie to the details view controller
       let detailViewController = segue.destination as! MovieDetailViewController
        detailViewController.movie = movie
        
        TableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
