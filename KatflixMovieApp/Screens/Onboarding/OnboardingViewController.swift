//
//  ViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 13.02.24.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    // MARK: private properties
    private var viewModel = OnboardingViewModel()
    
    // MARK: VC Lifecycle - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnboardingViewModel()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = viewModel.slides.count
    }
    // MARK: IBActions
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        if viewModel.isLastSlide {
            let controller = TabBarViewController.createTabbar()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true)
        } else {
            viewModel.moveToNextSlide()
            setNextButtonTitle()
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    // MARK: methods
    private func setNextButtonTitle() {
        pageControl.currentPage = viewModel.currentPage
        if viewModel.isLastSlide {
            nextButton.setTitle(NSLocalizedString("getStartedOnboarding", comment: ""), for: .normal)
        } else {
            nextButton.setTitle(NSLocalizedString("nextButtonOnboarding", comment: ""), for: .normal)
        }
    }
}
// MARK: - extension -   UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let model = viewModel.slides[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

// MARK: - extension -  UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage = Int(scrollView.contentOffset.x / width)
    }
}



