//
//  KategoriTableViewCell.swift
//  bltest
//
//  Created by Rian Sanjaya Ng on 05/02/19.
//  Copyright © 2019 Rian Sanjaya Ng. All rights reserved.
//

import UIKit

class KategoriTableViewCell: UITableViewCell {

    @IBOutlet weak var colKategori: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colKategori.delegate = self
        colKategori.dataSource = self
        getAPI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getAPI(){
        let url = "https://api.bukalapak.com/v2/categories.json"
        let urlObj = URL(string : url)
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            do{
                let x = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
//                print("Kategori json object")
//                print(x)
                let dataserial = try JSONSerialization.data(withJSONObject: x["categories"], options: [])
                let extractDataAPI = try JSONSerialization.jsonObject(with: dataserial, options: []) as! [[String: Any]]
//                print("Kategori convert data")
//                print(extractDataAPI)
                for repeatData in extractDataAPI{
                    let namaUrl = repeatData["name"] as? String
                    dataKategori.kategoriData.append(modelKategori(nameUrl: namaUrl!))
                }
                DispatchQueue.main.async {
                    self.colKategori.reloadData()
                }
            }catch{
                print(error)
            }
            }.resume()
    }
}

extension KategoriTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataKategori.kategoriData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colKategori.dequeueReusableCell(withReuseIdentifier: "colCellKategori", for: indexPath) as! KategoriCollectionViewCell
        cell.kategoriLable.text = dataKategori.kategoriData[indexPath.row].nameUrl
        return cell
    }


}
