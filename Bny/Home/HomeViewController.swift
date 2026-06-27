//
//  HomeViewController.swift
//  Bny
//
//  Created by Abirami on 23/06/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var gridImageView: UIImageView!
    @IBOutlet weak var gridView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bnyImageView: UIImageView!
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
    
    var deals: [Deals] = [
        Deals(image: "Deal3", title: "Burger Hub", distance: "2 km", offer: "20-50% Off", isFavourite: false),
        Deals(image: "Deal2", title: "Pizza Corner", distance: "4 km", offer: "15-40% Off", isFavourite: true),
        Deals(image: "Deal3", title: "South Indian Meals", distance: "1 km", offer: "10-30% Off", isFavourite: true),
        Deals(image: "Deal4", title: "Cafe & Coffee", distance: "3 km", offer: "25-50% Off", isFavourite: false),
        Deals(image: "Deal5", title: "Desserts", distance: "5 km", offer: "20-35% Off", isFavourite: false),
        Deals(image: "Deal6", title: "Restaurants - Dine In", distance: "4 km", offer: "20-50% Off", isFavourite: false)
    ]
       
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
        self.bnyImageView.layer.borderColor = UIColor(hex: "#20FFFFFF").cgColor
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
        
        self.setUpText()
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "BrandCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BrandCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = PinterestLayout()
        layout.delegate = self
        self.collectionView.collectionViewLayout = layout
    }
    
    func setUpText() {
        self.titleLbl.text = AppStrings.Home_Header_Title
        self.descriptionLbl.text = AppStrings.Home_Header_description
        let fullText = AppStrings.Home_Header_SubTitle
        
        let attributedString =
        NSMutableAttributedString(
            string: fullText,
            attributes: [
                .foregroundColor: UIColor.whiteClr
            ]
        )
        
        if let range = fullText.range(
            of: AppStrings.Deals,
            options: .caseInsensitive
        ) {
            
            let nsRange = NSRange(
                range,
                in: fullText
            )
            
            attributedString.addAttribute(
                .foregroundColor,
                value: UIColor.bnyRed,
                range: nsRange
            )
        }
        
        self.subTitleLbl.attributedText = attributedString
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
        let searchText = textField.text ?? ""
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

extension HomeViewController {
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
extension HomeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

extension HomeViewController: PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath) -> CGFloat {

        let image = UIImage(named: self.deals[indexPath.item].image)

        guard let image = image else {
            return 200
        }

        let columnWidth = (collectionView.frame.width / 2) - 12

        let ratio = image.size.height / image.size.width

        return columnWidth * ratio
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.deals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCollectionViewCell", for: indexPath) as! BrandCollectionViewCell

        let deal = self.deals[indexPath.item]
        cell.dealImageView.image = UIImage(named: deal.image)
        cell.titleLbl.text = deal.title
        cell.subtitleLbl.text = deal.distance + " " + deal.offer
        let imageName = deal.isFavourite ? "Fav_Fill" : "Fav_Unfill"
        cell.favouriteBtn.setImage(UIImage(named: imageName), for: .normal)
        cell.favouriteAction = { [weak self] in

            guard let self = self else {
                return
            }

            self.selectedIndexPath = indexPath

            self.showFavouritePopup(deal: deal)
            self.collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrandListViewController") as! BrandListViewController
        vc.headerTitle = self.titleLbl.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFavouritePopup(deal: Deals) {

        let popup = Bundle.main.loadNibNamed("FavouritePopupView", owner: self, options: nil)?.first as! FavouritePopupView

        popup.frame = self.view.bounds

        popup.configure(title: deal.isFavourite ? "Remove from Favorites?" : "Add to Favorites?", message: deal.isFavourite ? "Do you want to remove \(deal.title) from your favorites?" : "Do you want to add \(deal.title) to your favorites?", isFavourite: deal.isFavourite)

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

            self.deals[indexPath.item].isFavourite.toggle()

            self.collectionView.reloadItems(at: [indexPath])

            popup?.removeFromSuperview()
        }

        self.view.addSubview(popup)

        self.favouritePopup = popup
    }
}
