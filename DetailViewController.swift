//
//  DetailViewController.swift
//  MoveMe
//
//  Created by Brian Hillsley on 1/16/16.
//  Copyright © 2016 Brian Hillsley (codepath). All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movie: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set size of scrollable region
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.width)
        
        // Fetch and set the title
        let title = movie["title"] as? String
        movieTitleLabel.text = title
        
        // Fetch and set the overview description
        let overview = movie["overview"] as? String
        movieDescriptionLabel.text = overview
        
       // if(posterView == nil) { // If the poster view was already aquired then skip that step
            
        
            // Constants related to image URL creation
            let imgReqWidth = 600
            let baseUrl = "http://image.tmdb.org/t/p/w\(imgReqWidth)"
            
            // safer way of handling a dictionary that may or may not exist
            if let posterPath = movie["poster_path"] as? String {
                let imgCompleteUrl = NSURL(string: baseUrl + posterPath)!
                self.posterView.setImageWithURL(imgCompleteUrl)
            }
      //  }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
