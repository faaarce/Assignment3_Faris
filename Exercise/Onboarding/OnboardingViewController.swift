//
//  OnboardingViewController.swift
//  Exercise
//
//  Created by yoga arie on 18/07/24.
//

import UIKit

class OnboardingViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var startedButton: UIButton!
  
  var items: [Onboarding] = [
    Onboarding(image: "onboarding/Illustrations", title: "All your favorites", subtitle: "Order from the best local restaurants with easy, on-demand delivery."),
    Onboarding(image: "onboarding/Illustrations 1", title: "Free delivery offers", subtitle: "Free delivery for new customers via Apple Pay and others payment methods."),
    Onboarding(image: "onboarding/Illustrations 2", title: "Choose your food", subtitle: "Easily find your type of food craving and you’ll get delivery in wide range.")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    collectionView.register(UINib(nibName: "OnboardingViewCell", bundle: nil), forCellWithReuseIdentifier: "onboarding_cell")
  }
  
  func setup() {
    startedButton.layer.cornerRadius = 16
    collectionView.dataSource = self
    collectionView.delegate = self
    pageControl.currentPage = 0
    pageControl.numberOfPages = items.count
  }
  
  @IBAction func swipeButton(_ sender: Any) {
    let nextPage = pageControl.currentPage + 1
    if nextPage < items.count {
      let indexPath = IndexPath(item: nextPage, section: 0)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      pageControl.currentPage = nextPage
    } else {
      moveToSignInPage()
      
    }
  }
}

extension OnboardingViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboarding_cell", for: indexPath) as! OnboardingViewCell
    let onboarding = items[indexPath.item]
    cell.onboardingImage.image = UIImage(named: onboarding.image)
    cell.onboardingTitle.text = onboarding.title
    cell.onboardingSubtitle.text = onboarding.subtitle
    return cell
  }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let height = collectionView.frame.height
    return CGSize(width: screenWidth, height: height)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}

extension OnboardingViewController: UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x / scrollView.frame.width
    pageControl.currentPage = Int(page)
  }
  
}

