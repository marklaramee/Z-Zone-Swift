//
//  UIViewController+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import Foundation
import UIKit

extension UIViewController {

    /// Show a UIAlertController with the given title and message, using the style defined for Allbirds.
    func presentAlert(withTitle title: String, message: String, onDismiss: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            onDismiss?()
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

//    /// Show a simple alert popup
//    func presentSimplePopup(withTitle title: String, message: String, buttonText: String? = "OK", popupContentDelegate: PopupContentDelegate? = nil) {
//        let popupVC = PopupViewController.newInstance(popupContentDelegate: popupContentDelegate)
//        popupVC.showSimpleAlert(currentViewController: self,
//                                withTitle: title,
//                                message: message,
//                                buttonText: buttonText)
//    }
//
//    /// Show a custom alert popup
//    func presentCustomPopup(popupContentViewController: PopupContentViewController, popupContentDelegate: PopupContentDelegate? = nil) {
//        let popupVC = PopupViewController.newInstance(popupContentDelegate: popupContentDelegate)
//        popupContentViewController.popupViewController = popupVC
//        popupVC.showCustomAlert(currentViewController: self,
//                                popupContentViewController: popupContentViewController)
//    }

    /// Given a Storyboard file name, atempt to create a ViewController with an identifier equivalent to it's typename.
    /// CAUTION - This will crash if the given Storyboard or identifier is not found.
    static func buildFromStoryboard<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = String(describing: T.self)
        // swiftlint:disable force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier:
            identifier) as! T
        // swiftlint:enable force_cast

        return viewController
    }

    /// Loads a UIViewController with a matching identically named .xib file.
    /// CAUTION - This will crash if the no matching .xib file is found.
    static func buildFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }

    /// Helper to embed a ViewController inside of a UIView container.
    func addContentController(_ child: UIViewController, to view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
    }

    // Fade in the new content
    func addContentControllerWithAnimation(_ child: UIViewController, to view: UIView) {
        child.view.alpha = 0
        addContentController(child, to: view)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .transitionFlipFromLeft, animations: {
            child.view.alpha = 1
        }, completion: nil)
    }

    /// Helper to remove an embedded ViewController from inside of a UIView container.
    func removeContentController(_ child: UIViewController, from view: UIView) {
        // Check that view is actually a child before trying to remove
        guard view.subviews.contains(child.view) else {
            return
        }

        child.willMove(toParent: nil)
        view.willRemoveSubview(child.view)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    // Fade out the new content
    func removeContentControllerWithAnimation(_ child: UIViewController, from view: UIView) {
        // Check that view is actually a child before trying to remove
        guard view.subviews.contains(child.view) else {
            return
        }

        child.willMove(toParent: nil)
        view.willRemoveSubview(child.view)

        UIView.animate(withDuration: 0.5, delay: 0.1, options: .transitionFlipFromRight, animations: {
            child.view.alpha = 0
        }, completion: { _ in
            child.view.removeFromSuperview()
            child.removeFromParent()
        })
    }

//    func showCart() {
//        let cartController = CartViewController.newInstance()
//        cartController.modalPresentationStyle = .fullScreen
//        present(cartController, animated: true, completion: nil)
//    }
//
//    func showSearch(sourceScreen: String) {
//        navigationItem.searchController = nil
//
//        let searchViewController = SearchViewController()
//        searchViewController.sourceScreen = sourceScreen
//        searchViewController.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(searchViewController, animated: true)
//    }

//    func transitionNavigation(offset: CGFloat, appearance: DiscoverCardAppearance?, navigationView: UIView, searchController: UISearchController?) {
//        // As we scroll down, transition the nav bar to be solid
//        let transitionHeight: CGFloat = 100
//        let alphaOffset = min(1, offset / transitionHeight)
//
//        if appearance == .dark,
//           var newTextAttributes = navigationController?.navigationBar.titleTextAttributes {
//            // Transition to Allbirds Black
//            var redColor: CGFloat = (1 - alphaOffset) - 33/255
//            var greenColor: CGFloat = (1 - alphaOffset) -  42/255
//            var blueColor: CGFloat = (1 - alphaOffset) - 47/255
//            if offset <= 0 {
//                redColor = 1
//                greenColor = 1
//                blueColor = 1
//            }
//
//            let appearanceColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1)
//            newTextAttributes[NSAttributedString.Key.foregroundColor] = appearanceColor
//            navigationController?.navigationBar.titleTextAttributes = newTextAttributes
//
//            navigationController?.navigationBar.tintColor = appearanceColor
//        }
//
//        navigationView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alphaOffset)
//
//        searchController?.searchBar.alpha = alphaOffset
//    }
//
//    func setNavigationColor(_ color: UIColor) {
//        if var newTextAttributes = navigationController?.navigationBar.titleTextAttributes {
//            newTextAttributes[NSAttributedString.Key.foregroundColor] = color
//            newTextAttributes[NSAttributedString.Key.font] = UIFont(allbirdsFontStyle: .bold, size: AccessibilityUtil.shared.maxFontSize(12))
//            navigationController?.navigationBar.titleTextAttributes = newTextAttributes
//        }
//
//        navigationController?.navigationBar.tintColor = color
//    }

//    func share(shareItems: [Any], excluded: [UIActivity.ActivityType]? = nil, shareErrorMessage: String? = nil) {
//        // Fix to work around the issue described here. Essentially, when saving an image the UIActivityViewController
//        // will close to the presentingViewController. This seems to be a known bug. - https://developer.apple.com/forums/thread/119482
//        let invisibleViewController = UIViewController()
//        invisibleViewController.modalPresentationStyle = .overCurrentContext
//        invisibleViewController.view.backgroundColor = .clear
//
//        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//        activityViewController.excludedActivityTypes = excluded
//        activityViewController.modalPresentationStyle = .popover
//        activityViewController.popoverPresentationController?.sourceView = self.view // (sender as! UIButton) to = self.view
//
//        activityViewController.completionWithItemsHandler = { activity, success, items, error in
//            if let presentingViewController = invisibleViewController.presentingViewController {
//                presentingViewController.dismiss(animated: true, completion: nil)
//             } else {
//                invisibleViewController.dismiss(animated: false, completion: nil)
//             }
//
//            if let theError = error {
//                let errorMessage = shareErrorMessage ?? "We were unable to share."
//                Logger.shared.error(message: errorMessage, keyValues: ["error": theError.localizedDescription])
//            }
//        }
//
//        // Present the invisible viewcontroller and then present the activityview off of that to work around the bug.
//        self.present(invisibleViewController, animated: false) {
//            invisibleViewController.present(activityViewController, animated: true)
//        }
//    }
//
//    /// Recursively iterate up a hierarchy of UIViewControllers to find the top most view which is showing, starting from the current view.
//    var currentlyShowingViewController: UIViewController? {
//        if let controller = self as? UINavigationController {
//            return controller.topViewController?.currentlyShowingViewController
//        }
//        if let controller = self as? UISplitViewController {
//            return controller.viewControllers.last?.currentlyShowingViewController
//        }
//        if let controller = self as? UITabBarController {
//            return controller.selectedViewController?.currentlyShowingViewController
//        }
//        if let controller = presentedViewController {
//            return controller.currentlyShowingViewController
//        }
//        return self
//    }

    // inspo from: https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
//    func showBanner(_ banner: BannerModel) {
//        DispatchQueue.main.async {
//            guard let bannerView = BannerView.getBannerView(banner),
//                  let key = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
//                  key.subviews.contains(where: { $0 is BannerViewInternal }) == false else {
//                return
//            }
//
//            bannerView.frame = key.frame
//            bannerView.layer.opacity = 0
//            key.addSubview(bannerView)
//            bannerView.leadingAnchor.constraint(equalTo: key.leadingAnchor, constant: 0).isActive = true
//            bannerView.trailingAnchor.constraint(equalTo: key.trailingAnchor, constant: 0).isActive = true
//            bannerView.topAnchor.constraint(equalTo: key.topAnchor, constant: 0).isActive = true
//            bannerView.delegate = self
//
//            bannerView.superview?.setNeedsLayout()
//            bannerView.superview?.layoutIfNeeded()
//
//            let destinationHeight = bannerView.frame.size.height
//
//            let bannerHeightConstraint = bannerView.heightAnchor.constraint(equalToConstant: 0)
//            bannerHeightConstraint.isActive = true
//
//            bannerView.superview?.setNeedsLayout()
//            bannerView.superview?.layoutIfNeeded()
//
//            bannerView.layer.opacity = 1
//            UIView.animate(withDuration: 0.3) {
//                bannerHeightConstraint.constant = destinationHeight
//                bannerView.superview?.layoutIfNeeded()
//            }
//        }
//    }
}

//extension UIViewController: BannerViewDelegate {
//    func closeBanner(view bannerViewInternal: BannerViewInternal) {
//        bannerViewInternal.removeFromSuperview()
//        guard let banner = ShopConfig.shared.bannerViewModel.bannerRelay.value else {
//            return
//        }
//        ShopConfig.shared.bannerViewModel.saveDimissedId(banner.id)
//        ShopConfig.shared.bannerViewModel.bannerRelay.accept(nil)
//    }
//}

