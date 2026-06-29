//
//  DealerListViewController.swift
//  Bny
//
//  Created by Abirami on 27/06/26.
//

import UIKit

class BrandListViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var gridImageView: UIImageView!
    @IBOutlet weak var gridView: UIView!
//    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var hamburgerView: UIView!
    @IBOutlet weak var hamburgerBtn: UIButton!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var giftBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    var brandList: [BrandList] = [
        BrandList(image: "Deal3", title: "A2B", Location: "Anna Nagar", distance: "2 km", offer: "20-50% Off", isFavourite: false),
        BrandList(image: "Deal2", title: "Pizza Corner", Location: "Egmore", distance: "4 km", offer: "15-40% Off", isFavourite: true),
        BrandList(image: "Deal3", title: "South Indian Meals", Location: "T nagar", distance: "1 km", offer: "10-30% Off", isFavourite: true),
        BrandList(image: "Deal4", title: "Cafe & Coffee", Location: "Saidapet", distance: "3 km", offer: "25-50% Off", isFavourite: false),
        BrandList(image: "Deal5", title: "Desserts", Location: "Guindy", distance: "5 km", offer: "20-35% Off", isFavourite: false),
        BrandList(image: "Deal6", title: "Restaurants - Dine In", Location: "Tharamani", distance: "4 km", offer: "20-50% Off", isFavourite: false)
    ]
    var headerTitle = ""
    var isMenuOpen = false
    var selectedIndexPath: IndexPath?
    var favouritePopup: FavouritePopupView?
    var searchWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        self.setupMenuAnimation()
        self.setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func setUpUI() {
        self.menuContainerView.isHidden = true
        self.menuContainerView.alpha = 0
//        self.menuContainerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        self.gridView.layer.cornerRadius = self.gridView.frame.height/2
        self.gridView.layer.masksToBounds = true
        self.gridView.layer.borderColor = UIColor(named: "20FFFFFF")?.cgColor
        self.gridView.layer.borderWidth = 1
//        self.bnyImageView.layer.borderColor = UIColor(hex: "#20FFFFFF").cgColor
        self.gridView.layer.backgroundColor = UIColor.backgroundClr.cgColor
        self.searchContainerView.layer.cornerRadius = 20
        self.searchContainerView.layer.borderWidth = 1
        self.searchContainerView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        self.searchTextField.delegate = self
        
        self.searchTextField.attributedPlaceholder = NSAttributedString(
            string: AppStrings.SearchTF_Placeholder,
            attributes: [
                .foregroundColor: UIColor.whiteClr.withAlphaComponent(0.45)
            ]
        )
        self.searchTextField.textColor = .whiteClr
        self.searchTextField.tintColor = .whiteClr
        self.searchTextField.backgroundColor = .clear
//        searchContainerView.backgroundColor = UIColor(hex: "#1C2746")
        self.searchTextField.addTarget(
            self,
            action: #selector(searchTextChanged),
            for: .editingChanged
        )
        
        self.hamburgerView.layer.cornerRadius = self.hamburgerView.frame.height / 2
        self.hamburgerView.layer.borderWidth = 1
        self.hamburgerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.15).cgColor
        
        self.menuContainerView.layer.cornerRadius = 32
        self.menuContainerView.layer.borderWidth = 1
        self.menuContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.15).cgColor
        self.menuContainerView.isHidden = true
        
        self.menuContainerView.layer.shadowColor = UIColor.blackClr.cgColor
        self.menuContainerView.layer.shadowOpacity = 0.25
        self.menuContainerView.layer.shadowRadius = 15
        self.menuContainerView.layer.shadowOffset = CGSize(width: 0, height: 8)
        
        //back
        self.setUpBackView()
        self.setUpText()
    }
    
    func setUpBackView() {
        self.backContainerView.layer.cornerRadius = self.backContainerView.frame.height / 2
        self.backContainerView.layer.masksToBounds = true
        self.backContainerView.layer.borderWidth = 1
        self.backContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "BrandListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BrandListCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = PinterestLayout()
        layout.delegate = self
        self.collectionView.collectionViewLayout = layout
    }
    
    func setUpText() {
        self.titleLbl.text = self.headerTitle
        self.subTitleLbl.text = AppStrings.Find_The_Best_Offers
    }
    
    @IBAction func backBtn(_ sender: Any) {
        UIView.animateBackButton(view: self.backContainerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func hamburgerBtnTapped(_ sender: UIButton) {
        if self.isMenuOpen {
            self.closeMenu()
        } else {
            self.openMenu()
        }
    }
    
    @IBAction func profileBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self.closeMenu()
                // Navigate here
                // self.performSegue(...)
                // or
                // self.navigationController?.pushViewController(...)
            }

    }
    
    @IBAction func giftBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.closeMenu()
        }
    }
    
    @IBAction func notificationBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.closeMenu()
        }

    }
    
    @IBAction func favouriteBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.closeMenu()
        }

    }
    
    @IBAction func searchBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.closeMenu {
                self.searchTextField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        self.highlightMenuButton(sender)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.closeMenu()
        }
    }
    
    @objc func backgroundTapped() {

        self.closeMenu()
    }
    
    
    
    @objc func searchTextChanged(_ textField: UITextField) {
//        let searchText = textField.text ?? ""
        self.searchWorkItem?.cancel()

        let workItem = DispatchWorkItem {

//            self.callSearchAPI(
//                keyword: searchText
//            )
        }
        self.searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.5,
            execute: workItem
        )
    }
    
    func callSearchAPI(keyword: String) {
        print("Searching:", keyword)

        // API Call

//        HomeAPI.search(
//            keyword: keyword
//        ) { response in
//
//            self.dealsArray =
//            response.data
//
//            self.collectionView.reloadData()
//        }
    }
}


extension BrandListViewController {
    func animateHamburger(isOpen: Bool) {

        UIView.animate(withDuration: 0.22,
                       delay: 0,
                       options: .curveEaseInOut) {

            self.hamburgerBtn.transform = isOpen ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
    }
    
    func setupMenuAnimation() {
        self.backgroundView.isHidden = true
        self.backgroundView.backgroundColor = UIColor.clear
        self.menuContainerView.transform = .identity
        self.menuContainerView.alpha = 0
        self.menuContainerView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))

        self.backgroundView.addGestureRecognizer(tap)
    }
    
    func highlightMenuButton(_ button: UIButton) {

        button.backgroundColor = UIColor.white.withAlphaComponent(0.18)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {

            button.backgroundColor = .clear
        }
    }
    
    func closeMenu(completion: (() -> Void)? = nil) {
        
        self.isMenuOpen = false
        self.animateHamburger(isOpen: false)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {

            self.backgroundView.alpha = 0

            self.menuContainerView.alpha = 0

            self.menuContainerView.transform = CGAffineTransform(translationX: 0, y: 25)

        } completion: { _ in

            self.menuContainerView.isHidden = true

            self.backgroundView.isHidden = true

            self.backgroundView.alpha = 1

            self.menuContainerView.transform = .identity

            completion?()
        }
    }
    
    func openMenu() {

        self.isMenuOpen = true
        self.animateHamburger(isOpen: true)
        self.backgroundView.alpha = 0
        self.backgroundView.isHidden = false

        self.menuContainerView.isHidden = false

        self.menuContainerView.alpha = 0

        self.menuContainerView.transform = CGAffineTransform(translationX: 0, y: 25)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {

            self.menuContainerView.alpha = 1
            self.backgroundView.alpha = 1
            self.menuContainerView.transform = .identity
        }
    }
    
}

extension BrandListViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

extension BrandListViewController: PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath) -> CGFloat {

        let image = UIImage(named: self.brandList[indexPath.item].image)

        guard let image = image else {
            return 200
        }

        let columnWidth = (collectionView.frame.width / 2) - 12

        let ratio = image.size.height / image.size.width

        return columnWidth * ratio
    }
}

extension BrandListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brandList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandListCollectionViewCell", for: indexPath) as! BrandListCollectionViewCell

        let brandList = self.brandList[indexPath.item]
        cell.dealImageView.image = UIImage(named: brandList.image)
        cell.titleLbl.text = brandList.title
        cell.LocationLbl.text = brandList.Location
        cell.distanceLbl.text = brandList.distance + " " + brandList.offer
        let imageName = brandList.isFavourite ? "Fav_Fill" : "Fav_Unfill"
        cell.favouriteBtn.setImage(UIImage(named: imageName), for: .normal)
        cell.favouriteAction = { [weak self] in

            guard let self = self else {
                return
            }

            self.selectedIndexPath = indexPath

            self.showFavouritePopup(brandList: brandList)
            self.collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrandListViewController") as! BrandListViewController
        vc.headerTitle = self.titleLbl.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFavouritePopup(brandList: BrandList) {

        let popup = Bundle.main.loadNibNamed("FavouritePopupView", owner: self, options: nil)?.first as! FavouritePopupView

        popup.frame = self.view.bounds

        popup.configure(title: brandList.isFavourite ? AppStrings.Remove_from_Favorites : AppStrings.Add_to_Favorites, message: brandList.isFavourite ? AppStrings.Do_You_Want_To_Remove + " \(brandList.title) " + AppStrings.From_Your_Favorites : AppStrings.Do_You_Want_To_Add + " \(brandList.title) " + AppStrings.To_Your_Favorites, isFavourite: brandList.isFavourite)

        popup.cancelHandler = { [weak popup] in

            popup?.removeFromSuperview()
        }

        popup.actionHandler = { [weak self, weak popup] in
            
            guard let self = self else {
                return
            }

            guard let indexPath = self.selectedIndexPath else {
                return
            }

            self.brandList[indexPath.item].isFavourite.toggle()

            self.collectionView.reloadItems(at: [indexPath])

            popup?.removeFromSuperview()
        }

        self.view.addSubview(popup)

        self.favouritePopup = popup
    }
}
