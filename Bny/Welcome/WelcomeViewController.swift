//
//  WelcomeViewController.swift
//  Bny
//
//  Created by Abirami on 23/05/26.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    // MARK: - VARIABLES
    
    var currentIndex = 0
    
    
    private let gradientLayer = CAGradientLayer()
    var welcomeData: [WelcomeModel] = [
        
        WelcomeModel(
            image: "Welcome",
            title: AppStrings.Welcome_Title1,
            description: AppStrings.Welcome_SubTitle1
        ),
        
        WelcomeModel(
            image: "Welcome2",
            title: AppStrings.Welcome_Title2,
            description: AppStrings.Welcome_SubTitle2
        ),
        
        WelcomeModel(
            image: "Welcome3",
            title: AppStrings.Welcome_Title3,
            description: AppStrings.Welcome_SubTitle3
        )
    ]
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.addkeyboardGesture()
        self.updateUI()
//        self.setupGradientBackground()
        self.view.rewardHeaderGradient()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
        self.nextBtn.titleLabel?.font = UIFont.poppinsMedium(size: 16)
        self.buttonView.applyPremiumCardStyle()
    }
    
    // MARK: - SETUP UI
    func addkeyboardGesture(){
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    
    func setupUI() {
        
        self.pageControl.numberOfPages = welcomeData.count
        
        self.nextBtn.layer.cornerRadius = 30
        
        let attributedString = NSAttributedString(
            string: "SKIP",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.white,
                .font: UIFont.poppinsMedium(size: 16)
            ]
        )

        self.skipBtn.setAttributedTitle(
            attributedString,
            for: .normal
        )
    }
    
    // MARK: - COLLECTIONVIEW SETUP
    
//    private func setupGradientBackground() {
//        
//        gradientLayer.colors = [
//            UIColor(hex: "#D3163A").cgColor,
//            UIColor(hex: "#10192A").cgColor,
//            UIColor(hex: "#050B16").cgColor
//        ]
//        
//        gradientLayer.locations = [
//            0.0,
//            0.42,
//            1.0
//        ]
//        
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//        
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
    
    func updateUI() {

        self.pageControl.currentPage = currentIndex

        let isLastPage = currentIndex == welcomeData.count - 1

        self.skipBtn.isHidden = isLastPage

        let buttonTitle = isLastPage ? "START" : "NEXT"

        self.nextBtn.setTitle(buttonTitle, for: .normal)
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout
            as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        let nib = UINib(
            nibName: "WelcomeCollectionViewCell",
            bundle: nil
        )
        
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: "WelcomeCollectionViewCell"
        )
    }
    
    // MARK: - BUTTON ACTIONS
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
            if currentIndex < welcomeData.count - 1 {

                currentIndex += 1

                collectionView.scrollToItem(
                    at: IndexPath(item: currentIndex, section: 0),
                    at: .centeredHorizontally,
                    animated: true
                )

                updateUI()

            } else {

                let vc = storyboard?.instantiateViewController(
                        withIdentifier: "LoginViewController"
                    ) as! LoginViewController
                
                    navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
            }
        
    }
    
    @IBAction func skipBtnTapped(_ sender: UIButton) {
        
        print("Skip")
    }
}

// MARK: - COLLECTIONVIEW METHODS

extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return welcomeData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "WelcomeCollectionViewCell",
            for: indexPath
        ) as! WelcomeCollectionViewCell
        
        let data = welcomeData[indexPath.row]
        
        cell.configure(data: data)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
}

// MARK: - SCROLLVIEW METHODS

extension WelcomeViewController {
    
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        
        let page = Int(
            scrollView.contentOffset.x /
            scrollView.frame.width
        )
        
        currentIndex = page
        self.updateUI()
    }
}
