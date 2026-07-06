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

    var favouriteCategories: [String] = [
        AppStrings.Favourite_Category_HomeAppliances,
        AppStrings.Favourite_Category_Electronics,
        AppStrings.Favourite_Category_Fashion,
        AppStrings.Favourite_Category_Groceries,
        AppStrings.Favourite_Category_Restaurants
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

        self.mainView.applyRewardBackgroundGradient()

        self.tabContainerView.applyTabParentStyle()

        self.updateTabs()
    }

    // MARK: - UI

    func setupUI() {
        UIView.setUpBackView(view: self.backContainerView)
        self.tabContainerView.layer.cornerRadius = 20
        self.tabContainerView.layer.borderWidth = 1
        self.tabContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.12).cgColor

        self.bannerContainerView.layer.cornerRadius = 24
        self.bannerContainerView.layer.borderWidth = 1
        self.bannerContainerView.layer.borderColor = UIColor.whiteClr.withAlphaComponent(0.08).cgColor

        self.bannerContainerView.premiumCardGradient()

        self.bannerIconBackgroundView.layer.cornerRadius = self.bannerIconBackgroundView.frame.height / 2

        self.indicatorView.layer.cornerRadius = self.indicatorView.frame.width / 2

        [
            self.categoriesBtn,
            self.brandsBtn
        ].forEach {

            $0?.titleLabel?.font = .poppinsMedium(size: 16)
            $0?.layer.cornerRadius = 16
            $0?.clipsToBounds = true
        }
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

        self.favouritesCollectionView.register(
            UINib(nibName: "FavouriteCategoryCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "FavouriteCategoryCollectionViewCell"
        )
    }

    func updateTabs() {

        self.resetButtons()

        switch self.selectedTab {

        case .categories:

            self.selectButton(self.categoriesBtn)

            self.headerTitleLbl.text = "Favourite Categories"

        case .brands:

            self.selectButton(self.brandsBtn)

            self.headerTitleLbl.text = "Favourite Brands"
        }
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

extension FavouritesViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return favouriteCategories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FavouriteCategoryCollectionViewCell",
            for: indexPath
        ) as! FavouriteCategoryCollectionViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width,
                      height: 220)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

    }
}
