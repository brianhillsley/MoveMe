//
//  MovieViewController.swift
//  MoveMe
//
//  Created by Brian Hillsley on 1/16/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [NSDictionary]?
    
    func networkRequestToMoviesDB(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
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
                            NSLog("response: \(responseDictionary)")
                            // Set the results of the network request to be the array of movies
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            // RELOAD the collection view
                            self.collectionView.reloadData()
                    }
                }
        });
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
        
        // MAke sure movies is not nil
        if let movies = movies {
            return movies.count
        }
        return 0
        
    }
    
    
    // From UICollectionViewDataSource protocol
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movieDictionary = movies![indexPath.row]
        cell.movieTitle!.text = "\(movieDictionary["title"]!)"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // load detailed view controller
        self.performSegueWithIdentifier("showMovieDetails", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        
        let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
        let indexPath = indexPaths[0] as NSIndexPath
        
        let vc = segue.destinationViewController as! DetailViewController
        
        // vc.imageView = movies[indexPath.row]!.imageView
        // vc.title = movies[indexPath.row]!.title
        
    }
    

}
