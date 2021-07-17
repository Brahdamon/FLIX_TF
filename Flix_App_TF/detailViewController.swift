//
//  detailViewController.swift
//  Flix_App_TF
//
//  Created by Christopher LaBorde on 7/16/21.
//

import UIKit
import AlamofireImage

class detailViewController: UIViewController {

    var movie: [String:Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let posterPath = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterURL = URL(string: baseURL + posterPath)!
        
      posterView.af.setImage(withURL: posterURL)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseURL + backdropPath)!
        
        backdropView.af.setImage(withURL: backdropURL)
        
        
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
