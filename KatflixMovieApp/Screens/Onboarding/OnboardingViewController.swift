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
    
    private let viewModel = OnboardingViewModel()
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == viewModel.slides.count - 1 {
                nextButton.setTitle(OnboardingSlidesLocalization.getStarted.string, for: .normal)
            } else {
                nextButton.setTitle(OnboardingSlidesLocalization.nextButton.string, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlides()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = viewModel.slides.count
        
    }
    
    func createSlides() {
        viewModel.slides =  [OnboardingModel(title: OnboardingSlidesLocalization.titleSlide1.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide1.string,
                                   image: UIImage(named: "Slide1")),
                   OnboardingModel(title: OnboardingSlidesLocalization.titleSlide2.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide2.string,
                                   image: UIImage(named: "Slide2")),
                   OnboardingModel(title: OnboardingSlidesLocalization.titleSlide3.string,
                                   description: OnboardingSlidesLocalization.descriptionSlide3.string,
                                   image: UIImage(named: "Slide3"))]
    }
    
    @IBAction func nextButtonDidTap(_ sender: UIButton) {
        if currentPage == viewModel.slides.count - 1 {
            let controller = TabBarViewController.createTabbar()
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setupCollectionViewCell(viewModel: viewModel.slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
       
    }
}

