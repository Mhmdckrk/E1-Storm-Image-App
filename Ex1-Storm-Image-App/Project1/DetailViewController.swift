//
//  DetailViewController.swift
//  Project1
//
//  Created by Mahmud CIKRIK on 24.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    // 1.Step: We need to create a property in DetailViewController that will hold the name of the image to load.
    
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "\(selectedPictureNumber) of \(totalPictures)"
        
        
        // title = selectedImage
        //bunların ikisi de optional olduğu için tekrar optional yapmana gerek yok.
        navigationItem.largeTitleDisplayMode = .never
        
        
        // 3.Step: Finally, we’ll fill in viewDidLoad() inside DetailViewController so that it loads an image into its image view based on the name we set earlier.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
