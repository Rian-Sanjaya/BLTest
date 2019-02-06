//
//  BannerTableViewCell.swift
//  bltest
//
//  Created by Rian Sanjaya Ng on 04/02/19.
//  Copyright © 2019 Rian Sanjaya Ng. All rights reserved.
//

import UIKit
import SDWebImage

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var colView: UICollectionView!
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colView.delegate = self
        colView.dataSource = self
        setTimer()
        getAPI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedView != nil) {
            colView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func setTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if index < bannerData.data.count {
            let indexPath = IndexPath(item: index, section: 0)
            colView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            index += 1
        } else {
            index = 0
            colView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func getAPI() {
        let url = "https://api.bukalapak.com/v2/flash_banners.json"
        let urlObj = URL(string: url)
        
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            do{
                let x = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print("First json object")
                print(x)
                let dataserial = try JSONSerialization.data(withJSONObject: x["banners"] as Any, options: [])
                print("Extract Key Banner")
                print(dataserial)
                
                let extractDataAPI = try JSONSerialization.jsonObject(with: dataserial, options: []) as! [[String: Any]]
                print("Banner json object")
                print(extractDataAPI)
                for repeatData in extractDataAPI{
                    let imageUrl = repeatData["image"] as? String
                    bannerData.data.append(bannerModel(imageUrl: imageUrl!))
                }
                DispatchQueue.main.async {
                    self.colView.reloadData()
                }
            }catch{
                print(error)
            }
            }.resume()
    }

}

extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerData.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "collecBanner", for: indexPath) as! BannerCollectionViewCell
//        let  imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.jpg"), placeholderImage: UIImage(named: "placeholder.png"))
        let imagesource = bannerData.data[indexPath.row].imageUrl
        cell.imageBanner.sd_setImage(with: URL(string: imagesource), placeholderImage: nil, options: .refreshCached)
        cell.pgControl.currentPage = indexPath.row
        return cell
    }


}
