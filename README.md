# ZoomableImage
Zoomable Image with page controller.
This library provides an async image slider using SDWebImage dependency.

<b>How to use :

<b>*Swift

#Import Both files and Use blow code.

let imagesURL = ["https://images.pexels.com/photos/1040626/pexels-photo-1040626.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                "https://images.pexels.com/photos/799443/pexels-photo-799443.jpeg?auto=format%2Ccompress&cs=tinysrgb&dpr=1&w=500",
                "https://storage-asset.msi.com/global/picture/wallpaper/wallpaper_15562596175cc2a321d93ab.jpg",
                "http://webneel.com/wallpaper/sites/default/files/images/01-2014/2-flower-wallpaper.jpg"]

let viewController = SliderPagerViewController(images: imagesURL, currentIndex: 0, placeHolderImage: UIImage(named: ""))

self.present(viewController, animated: true, completion: nil)</i>

