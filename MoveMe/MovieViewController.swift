//
//  MovieViewController.swift
//  MoveMe
//
//  Created by Brian Hillsley on 1/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
    UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var filteredMovies: [NSDictionary]?
    
    var movies: [NSDictionary]?
    
    var dbEndpoint: String!
    
    // Grab data from movie database
    func networkRequestToMoviesDB(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(dbEndpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    // From JSON to NSDictionary
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            // Set the results of the network request to be the array of movies
                            self.movies = (responseDictionary["results"] as! [NSDictionary])
                            self.filteredMovies = (responseDictionary["results"] as! [NSDictionary])
                            // RELOAD the collection view
                            self.collectionView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        filteredMovies = searchText.isEmpty ? movies: movies!.filter({(mov: NSDictionary) -> Bool in
            let movStr:String! = mov["title"] as! String
            return  movStr.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
        collectionView.reloadData()
    }
    
    
    // Called on refresh
    func didRefresh(){
        networkRequestToMoviesDB() // Grab data from movie database
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        // Call to MOVIE DATABASE
        networkRequestToMoviesDB()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From UICollectionViewDataSource protocol
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredMovies != nil {
            return filteredMovies!.count
        }
        if movies != nil {
            return movies!.count
        }
        return 0
        }
    
    
    // From UICollectionViewDataSource protocol
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        cell.backgroundColor = UIColor.darkGrayColor()
        // Grab the SINGLE SELECTED MOVIE to use as reference
        

        let movieDictionary = filteredMovies![indexPath.row]
        
        
        // Constants related to image URL creation
        let imgReqWidth = 150
        let baseUrl = "http://image.tmdb.org/t/p/w\(imgReqWidth)"
        
        // safer way of handling a dictionary that may or may not exist
        if let posterPath = movieDictionary["poster_path"] as? String {
            let imgCompleteUrl = NSURL(string: baseUrl + posterPath)!
            cell.posterView.setImageWithURL(imgCompleteUrl)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // load detailed view controller
        self.performSegueWithIdentifier("showMovieDetails", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showMovieDetails"){
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let movie = filteredMovies![indexPath.row]
            let vc = segue.destinationViewController as! DetailViewController
            
            // Get the new view controller using segue.destinationViewController.
            // vc.imageView = movies[indexPath.row]!.imageView
            vc.movie = movie
        }
        
    }
}