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
    
}

