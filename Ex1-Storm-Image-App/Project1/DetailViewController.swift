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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
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
    
    @objc func shareTapped () {
        
        guard let image = imageView.image else {
            print("No image found")
            return
        }
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: .zero)
        
        let text = "Image From Storm Viewer App" // Eklemek istediğiniz metin
        
        // Metin özellikleri
        let textFont = UIFont.systemFont(ofSize: 20)
        let textColor = UIColor.white
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        
        // Metni çizin
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        
        let textRect = CGRect(x: 0, y: image.size.height - 40, width: image.size.width - 20 , height: 70) // Metin konumu ve boyutu
        
//        UIColor.red.setFill() // Arkaplan rengini kırmızı olarak ayarlayın
//        UIRectFill(textRect)
        text.draw(in: textRect, withAttributes: textAttributes)
        
        
        guard let renderedImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        // let renderedImage olarakta alabilirsin ama best practise böyle
        UIGraphicsEndImageContext()
        
        
        guard let renderedImageData = renderedImage.jpegData(compressionQuality: 0.8) else {
            print("Failed to render Image")
            return }
        
        
        let name = "\(selectedImage ?? "foto")"
        
        let vc = UIActivityViewController(activityItems: [renderedImageData, name], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
  
    }
    

}
