//
//  ViewController.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 13.02.24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var viewModel = OnboardingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = OnboardingViewModel()
       
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = viewModel.slides.count
    }
    
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
    
    func setNextButtonTitle() {
        pageControl.currentPage = viewModel.currentPage
        if viewModel.isLastSlide {
            nextButton.setTitle(OnboardingSlidesLocalization.getStarted.string, for: .normal)
        } else {
            nextButton.setTitle(OnboardingSlidesLocalization.nextButton.string, for: .normal)
        }
    }
}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let model = viewModel.slides[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage = Int(scrollView.contentOffset.x / width)
    }
}

