//
//  ProfileController.swift
//  UI_Project
//
//  Created by Shisetsu on 21.12.2020.
//

import UIKit

class ProfileController: UIViewController {
    
    var userPhoto: UIImage!
    var userName: String!
    var userSurname: String!
    var userCity: String!
    var userBirth: String!
    var userAge: String!
    var userStatus: String!
    var userBio: String!
    //var userGalery:[UIImage]!
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var bio: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGestureRecognizer)
        
        avatar.image = userPhoto
        name.text = userName
        surname.text = userSurname
        city.text = userCity
        birthDate.text = userBirth
        age.text = userAge
        status.text = userStatus
        if status.text == "Offline" {
            status.textColor = UIColor.red
        } else {
            status.textColor = UIColor.green
        }
        bio.text = userBio
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoGallery") as! CollectionViewController
        vc.userPhoto = avatar.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
