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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredMovies = searchBar.text!.isEmpty ? movies: movies!.filter({(mov: NSDictionary) -> Bool in
            let movStr:String! = mov["title"] as! String
            return  movStr.rangeOfString(searchBar.text!, options: .CaseInsensitiveSearch) != nil
        })
        collectionView.reloadData()
        
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
        print("Did refresh method was called")
        networkRequestToMoviesDB() // Grab data from movie database
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        // Add the UIRefreshControl to the CollectionView
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        // Call to MOVIE DATABASE
        networkRequestToMoviesDB()
        
        
        // Do any additional setup after loading the view.
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
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
                refreshControl.endRefreshing()
        });
        task.resume()
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
        
        
            
            // safer way of handling a dictionary that may or may not exist
            if let posterPath = movieDictionary["poster_path"] as? String {
            
            // Constants related to image URL creation
            let lowResWidth = 150
            let highResWidth = 600
            let smallImageUrl = (string: "http://image.tmdb.org/t/p/w\(lowResWidth)"+posterPath)
            let largeImageUrl = (string:"http://image.tmdb.org/t/p/w\(highResWidth)"+posterPath)
            // Update or download image URL for the selected movie cell
            

                let smallImageRequest = NSURLRequest(URL: NSURL(string: smallImageUrl)!)
                let largeImageRequest = NSURLRequest(URL: NSURL(string: largeImageUrl)!)
                
                cell.posterView.setImageWithURLRequest(
                    smallImageRequest,
                    placeholderImage: nil,
                    success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                        
                        
                        // smallImageResponse will be nil if the smallImage is already available
                        // in cache (might want to do something smarter in that case).
                        cell.posterView.alpha = 0.0
                        cell.posterView.image = smallImage;
                        
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            
                            cell.posterView.alpha = 1.0
                            
                            }, completion: { (sucess) -> Void in
                                
                                // The AFNetworking ImageView Category only allows one request to be sent at a time
                                // per ImageView. This code must be in the completion block.
                                cell.posterView.setImageWithURLRequest(
                                    largeImageRequest,
                                    placeholderImage: smallImage,
                                    success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                        
                                        cell.posterView.image = largeImage;
                                        
                                    },
                                    failure: { (request, response, error) -> Void in
                                        // do something for the failure condition of the large image request
                                        // possibly setting the ImageView's image to a default image
                                })
                        })
                    },
                    failure: { (request, response, error) -> Void in
                        // do something for the failure condition
                        // possibly try to get the large image
                })
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
            let vc:DetailViewController = segue.destinationViewController as! DetailViewController
            
            // Get the new view controller using segue.destinationViewController.
            // vc.imageView = movies[indexPath.row]!.imageView
            vc.movie = movie
            
            // Copy over the poster instead of re-fetching it.
            // If the high resolution one was already downloaded, then it won't need to do it again in the detailed view controller
            //vc.posterView = (collectionView.cellForItemAtIndexPath(indexPaths[0] as NSIndexPath) as! MovieCell).posterView.mutableCopy() as! UIImageView
        }
        
    }
}