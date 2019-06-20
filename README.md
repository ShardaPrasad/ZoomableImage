# ZoomableImage
Zoomable Image with page controller.
This library provides an async image slider using SDWebImage.

How to use :

let viewController = SliderPagerViewController(images: images, currentIndex: 0, placeHolderImage: UIImage(named: ""))
self.present(viewController, animated: true, completion: nil)

