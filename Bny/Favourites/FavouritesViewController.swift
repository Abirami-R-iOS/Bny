//
//  FavouritesViewController.swift
//  Bny
//
//  Created by Abirami on 03/07/26.
//

import UIKit



class FavouritesViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!


    @IBOutlet weak var tabContainerView: UIView!

    @IBOutlet weak var categoriesBtn: UIButton!

    @IBOutlet weak var brandsBtn: UIButton!

    @IBOutlet weak var bannerContainerView: UIView!

    @IBOutlet weak var bannerIconBackgroundView: UIView!

    @IBOutlet weak var bannerIconImageView: UIImageView!

    @IBOutlet weak var bannerTitleLbl: UILabel!

    @IBOutlet weak var bannerSubTitleLbl: UILabel!

    @IBOutlet weak var indicatorView: UIView!

    @IBOutlet weak var headerTitleLbl: UILabel!

    @IBOutlet weak var viewAllBtn: UIButton!

    @IBOutlet weak var favouritesCollectionView: UICollectionView!

    // MARK: - Variables

    var selectedTab: FavouriteTab = .categories

    var favouriteCategories: [FavouriteCategory] = [
        FavouriteCategory(image: "Deal1", title: "Home Appliances", count: 10),
        FavouriteCategory(image: "Deal2", title: "Electronics", count: 18),
        FavouriteCategory(image: "Deal3", title: "Fashion", count: 25)
    ]

    var favouriteBrands: [FavouriteBrand] = [
        FavouriteBrand(image: "Deal1", title: "A2B", subtitle: "Exciting Offer", distance: "5"),
        FavouriteBrand(image: "Deal2", title: "Star Biriyani", subtitle: "Limited Offer", distance: "5"),
        FavouriteBrand(image: "Deal3", title: "Salem RR", subtitle: "", distance: "5")
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()

        self.setupCollectionView()

        self.updateTabs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        self.mainView.applyRewardBackgroundGradient()
        self.tabContainerView.applyTabParentStyle()
        self.bannerContainerView.premiumCardGradient()
        
       
        
//        self.updateTabs()
    }

    // MARK: - UI

    func setupUI() {
        UIView.setUpBackView(view: self.backContainerView)
        
        self.bannerContainerView.layer.cornerRadius = 24
        self.bannerContainerView.layer.masksToBounds = true
        self.bannerContainerView.layer.borderWidth = 1
        self.bannerContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor
        
        self.tabContainerView.layer.cornerRadius = 20
        self.tabContainerView.layer.borderWidth = 1
        self.tabContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor
        self.bannerIconBackgroundView.layer.cornerRadius = self.bannerIconBackgroundView.frame.height / 2
        self.indicatorView.layer.cornerRadius = self.indicatorView.frame.width / 2

        [
            self.categoriesBtn,
            self.brandsBtn
        ].forEach {

            $0?.titleLabel?.font = .poppinsMedium(size: 12)
            $0?.layer.cornerRadius = 10
            $0?.clipsToBounds = true
        }
        self.viewAllBtn.titleLabel?.font = .poppinsMedium(size: 9.0)
        self.viewAllBtn.setTitle(AppStrings.View_All, for: .normal)
        self.setUpTexts()
    }
    
    func setUpTexts() {
        self.titleLbl.text = AppStrings.Favourites_Title
        self.subTitleLbl.text = AppStrings.Favourites_SubTitle

        self.categoriesBtn.setTitle(AppStrings.Favourite_Categories_Tab, for: .normal)
        self.brandsBtn.setTitle(AppStrings.Favourite_Brands_Tab, for: .normal)

        self.bannerTitleLbl.text = AppStrings.Favourite_Banner_Title
        self.bannerSubTitleLbl.text = AppStrings.Favourite_Banner_SubTitle

        self.headerTitleLbl.text = AppStrings.Favourite_Categories_Title

        self.viewAllBtn.setTitle(AppStrings.Favourite_View_All, for: .normal)
    }

    func setupCollectionView() {

        self.favouritesCollectionView.delegate = self

        self.favouritesCollectionView.dataSource = self

        self.favouritesCollectionView.backgroundColor = .clear

        self.favouritesCollectionView.showsVerticalScrollIndicator = false

        self.favouritesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        if let layout = self.favouritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.scrollDirection = .vertical

            layout.minimumLineSpacing = 16

            layout.minimumInteritemSpacing = 16

            layout.sectionInset = .zero
        }

        self.favouritesCollectionView.register(
            UINib(nibName: "FavouriteCategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "FavouriteCategoryCollectionViewCell"
        )

        self.favouritesCollectionView.register(
            UINib(nibName: "FavouriteBrandCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "FavouriteBrandCollectionViewCell"
        )
    }

//    func updateTabs() {
//
//        self.resetButtons()
//
//        switch self.selectedTab {
//
//        case .categories:
//
//            self.selectButton(self.categoriesBtn)
//
//            self.headerTitleLbl.text = "Favourite Categories"
//
//        case .brands:
//
//            self.selectButton(self.brandsBtn)
//
//            self.headerTitleLbl.text = "Favourite Brands"
//        }
//    }
    
    func updateTabs() {

        self.resetButtons()

        switch self.selectedTab {

        case .categories:

            self.selectButton(self.categoriesBtn)

            self.headerTitleLbl.text = AppStrings.Favourite_Categories_Title

        case .brands:

            self.selectButton(self.brandsBtn)

            self.headerTitleLbl.text = AppStrings.Favourite_Brands_Title
        }

        //self.favouritesCollectionView.reloadData()
    }
    
    

    func resetButtons() {

        [
            self.categoriesBtn,
            self.brandsBtn
        ].forEach {

            $0?.removeSelectedTabGradient()
            $0?.backgroundColor = .clear
            $0?.setTitleColor(.silverClr, for: .normal)
        }
    }

    func selectButton(_ button: UIButton) {

        button.applySelectedTabGradient()

        button.setTitleColor(.whiteClr, for: .normal)
    }

    // MARK: - Actions

    @IBAction func backTapped(_ sender: UIButton) {
        self.navigateBack(sender: sender)
    }
    
    @IBAction func categoriesTapped(_ sender: UIButton) {

        self.selectedTab = .categories

        self.updateTabs()

        self.favouritesCollectionView.reloadData()
    }

    @IBAction func brandsTapped(_ sender: UIButton) {

        self.selectedTab = .brands

        self.updateTabs()

        self.favouritesCollectionView.reloadData()
    }

    @IBAction func viewAllTapped(_ sender: UIButton) {

    }
}

// MARK: - UICollectionView

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch self.selectedTab {

        case .categories:
            return self.favouriteCategories.count

        case .brands:
            return self.favouriteBrands.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch self.selectedTab {

        case .categories:

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FavouriteCategoryCollectionViewCell",
                for: indexPath
            ) as! FavouriteCategoryCollectionViewCell

            let item = self.favouriteCategories[indexPath.item]

            cell.configure(
                image: item.image,
                title: item.title,
                count: item.count
            )

            return cell

        case .brands:

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FavouriteBrandCollectionViewCell",
                for: indexPath
            ) as! FavouriteBrandCollectionViewCell

            let item = self.favouriteBrands[indexPath.item]

            cell.configure(
                image: item.image,
                title: item.title,
                subTitle: item.subtitle,
                distance: item.distance
            )

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch self.selectedTab {

        case .categories:

            let padding: CGFloat = 16
            let spacing: CGFloat = 16

            let width = (collectionView.frame.width - padding - spacing) / 2

            return CGSize(width: width, height: 180)

        case .brands:

            return CGSize(width: collectionView.frame.width, height: 110)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 16
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 16
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }
}
