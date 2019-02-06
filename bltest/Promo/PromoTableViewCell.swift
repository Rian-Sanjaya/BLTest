//
//  PromoTableViewCell.swift
//  bltest
//
//  Created by Rian Sanjaya Ng on 06/02/19.
//  Copyright © 2019 Rian Sanjaya Ng. All rights reserved.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    @IBOutlet weak var promoColl: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        promoColl.delegate = self
        promoColl.dataSource = self
        getAPI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getAPI(){
        let url = "https://api.bukalapak.com/v2/products/promo_banners.json?version=2"
        let urlObj = URL (string: url)
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error)
            in
            do{
                let x = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let dataserial = try JSONSerialization.data(withJSONObject: x["promo_banners"], options: [])
                let extractDataAPI = try JSONSerialization.jsonObject(with: dataserial, options: []) as! [[String: Any]]
                print("Promo Data")
                print(extractDataAPI)
                for repeatData in extractDataAPI{
                    let namaUrl = repeatData["description"] as? String
                    let imageUrl = repeatData["image"] as? String
                    dataPromo.promoData.append(modelPromo(deskripsiUrl: namaUrl!, imageUrl: imageUrl!))
//                    print(namaUrl)
                }
                DispatchQueue.main.async {
                    self.promoColl.reloadData()
                }
            }catch{
                print(error)
            }
            }.resume()
    }
}

extension PromoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPromo.promoData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = promoColl.dequeueReusableCell(withReuseIdentifier: "promoCollCell", for: indexPath) as! PromoCollectionViewCell
        let deskripsi = dataPromo.promoData[indexPath.row].deskripsiUrl
        let imageSource = dataPromo.promoData[indexPath.row].imageUrl
        cell.imagePromo.sd_setImage(with: URL (string: imageSource), placeholderImage: nil, options: .refreshCached)
        cell.judulPromo.text = deskripsi
        return cell
    }
}

//extension PromoTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat =  50
//        let collectionViewSize = collectionView.frame.size.width - padding
//
//        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
//    }
//}
