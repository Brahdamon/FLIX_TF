//
//  GridViewController.swift
//  Flix_App_TF
//
//  Created by Christopher LaBorde on 7/16/21.
//

import UIKit
import AlamofireImage

class GridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    var movies = [[String:Any]]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        
        
        let url = URL(string:  // "https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        
        "https://api.themoviedb.org/3/movie/497698/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
                print(self.movies)
                
        // Do any additional setup after loading the view.
    }
    
        }
        task.resume()
        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCollectionViewCell", for: indexPath) as! MovieGridCollectionViewCell
        
        let movie = movies[indexPath.item]
        
        let posterPath = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500/"
        let posterURL = URL(string: baseURL + posterPath)!
        
        cell.posterView.af.setImage(withURL: posterURL)

        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        // sets the gridCellViewController as the destination for the segue, or "click"
        let gridDetailViewController =  segue.destination as! GridDetailViewController
        
        gridDetailViewController.movie = movie
    }
    
}
