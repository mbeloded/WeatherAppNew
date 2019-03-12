//
//  WeatherItemTableViewCell.swift
//  weatherApp
//
//  Created by Michael Bielodied on 3/11/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import UIKit

class WeatherItemTableViewCell: UITableViewCell {
    
    //MARK : variables
    
    fileprivate let imageCache = NSCache<AnyObject, AnyObject>()
    fileprivate var returnImage = UIImage()
    
    fileprivate let placeholderImage = UIImage(named: "ic_placeholder")!
    fileprivate var imgsCnt = 0
    fileprivate var imagesListArray = [UIImage]()
    
    var viewModel: WeatherItemViewModel? {
        didSet {
            if let viewModel = viewModel {
                titleLabel.text = viewModel.title
                subtitleLabel.text = viewModel.subtitle
                degreesLabel.text = viewModel.degrees
                
                imgsCnt = viewModel.icons.count
                imagesListArray = viewModel.icons.map { (iconName) -> UIImage in
                    return returnImageUsingCache(with: String(format: Common.getWeatherConditionIcon, iconName))
                }

                reloadIcons()
            }
        }
    }
    
    //MARK: outlets
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.style = LabelStyle.title.rawValue
        }
    }
    
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.style = LabelStyle.subtitle.rawValue
        }
    }
    
    @IBOutlet weak var degreesLabel: UILabel! {
        didSet {
            degreesLabel.style = LabelStyle.degree.rawValue
        }
    }
    
    @IBOutlet weak var weatherIcons: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func reloadIcons() {
        
        weatherIcons.animationImages = imagesListArray
        weatherIcons.animationDuration = 2.0
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.weatherIcons.startAnimating()
        }
        
    }
    
    fileprivate func returnImageUsingCache(with urlString: String) -> (UIImage) {
        
        // First check if there is an image in the cache
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            return cachedImage
        } else {
            // Otherwise download image using the url location in Google Firebase
            returnImage = placeholderImage
            
            let completionHandler: (Result<Data, ErrorResult>) -> Void = { (result) in
                
                switch result {
                case .success(let data) :

                        DispatchQueue.main.async { [weak self] in
                            
                            print("\ndownload completed")
                            guard let self = self else {
                                return
                            }
                            
                            // Cache to image so it doesn't need to be reloaded everytime the user scrolls and table cells are re-used.
                            if let downloadedImage = UIImage(data: data) {
                                
                                self.imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                                self.returnImage = downloadedImage
                                
                                self.imagesListArray.remove(at: self.imagesListArray.firstIndex(of: self.placeholderImage) ?? 0)
                                
                                self.imagesListArray.append(downloadedImage)
                            }
                            
                            self.imgsCnt -= 1
                            
                            if self.imgsCnt == 0 {
                                self.reloadIcons()
                            }
                        }
                        
                    break
                    
                case .failure(let error) :
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                        self.contentMode = .center
                        self.returnImage = self.placeholderImage
                    }
                    break
                    
                }
            }
            
            APIService.init().get(urlString: urlString, completion: completionHandler)
            return returnImage
            
        }
    }
    
}
