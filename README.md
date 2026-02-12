# VisualDiscoverySDK

VisualDiscoverySDK is a comprehensive Swift library designed to integrate visual product discovery, image detection, and similarity search features into your iOS applications. It streamlines the process of interacting with the Visual Discovery API.

## Features

- 📷 **Image Detection:** Detect products within an uploaded image.
- 🔍 **Visual Search:** Search for products using visual inputs.
- 🔄 **Similarity Search:** Find similar products based on a specific product ID.
- 📊 **Event Tracking:** Send analytical events for user interactions.
- 🖼️ **Built-in UI:** Includes a ready-to-use `VDUploadVC` for handling image uploads easily.

## Requirements

- **iOS** 15.0+
- **Swift** 5.0+
- **UIKit**

---

## Installation

### Swift Package Manager (SPM)

You can easily install `VisualDiscoverySDK` via Swift Package Manager.

1. In Xcode, navigate to **File > Add Packages...**
2. In the search bar, enter the repository URL:

```text
https://github.com/segmenthub/VisualDiscovery.SDK.iOS.git
```

3. Select the version you want to install and add it to your target.

---

## Configuration

You must provide a valid **Account ID** to authenticate your requests. You can configure this in two ways:

### Option 1: Info.plist (Recommended)

Add your Account ID to your application's `Info.plist` file.

1. Open `Info.plist`.
2. Add a new key named `VDAccountID`.
3. Set its value to your account ID string.

**XML Representation:**
```xml
<key>VDAccountID</key>
<string>YOUR_ACCOUNT_ID_HERE</string>
```

### Option 2: Programmatic Configuration

If you prefer not to use `Info.plist` or need to set the ID dynamically (e.g., from a backend response), use the `configure` method. This should be done as early as possible, typically in your `AppDelegate`.

```swift
import VisualDiscoverySDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Configure the SDK manually
    VisualDiscoverySDK.shared.configure(account_id: "YOUR_ACCOUNT_ID")
    
    return true
}
```

---

## Usage

### 1. Detecting Products from an Image

Use the `detect` method to analyze an image and retrieve product information.

```swift
import VisualDiscoverySDK

let myImage = UIImage(named: "sample_shoes")!

VisualDiscoverySDK.shared.detect(image: myImage) { response, error in
    if let error = error {
        print("Error detecting image: \(error.localizedDescription)")
        return
    }
    
    if let response = response {
        print("Detection successful. Found items: \(response)")
        // Process the response model here
    }
}
```

### 2. Using the Built-in Upload UI

The SDK provides a built-in view controller (`VDUploadVC`) to handle image picking and uploading automatically.

1. Implement `VisualDiscoverySDKProtocol` in your view controller.
2. Set the `delegate`.
3. Call `openUploadPageFor(containerVC:)`.

```swift
import UIKit
import VisualDiscoverySDK

class HomeViewController: UIViewController, VisualDiscoverySDKProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Set the delegate to receive results
        VisualDiscoverySDK.shared.delegate = self
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        // 2. Open the built-in upload page
        VisualDiscoverySDK.shared.openUploadPageFor(containerVC: self)
    }

    // MARK: - VisualDiscoverySDKProtocol
    
    // This method is called when a product is selected from the SDK's UI
    func visiualDiscoveryProductSelected(product: VDProductItem) {
        print("User selected product: \(product)")
        // Navigate to your product detail page or handle the selection
    }
}
```

### 3. Finding Similar Products

To fetch products similar to a specific item:

```swift
let productId = "12345"
let requestId = "req_abc123"

VisualDiscoverySDK.shared.getSimilarsFor(productId: productId, requestId: requestId) { response, error in
    if let error = error {
        print("Error fetching similar items: \(error)")
        return
    }
    
    if let response = response {
        // Update your UI with the list of similar products
        print(response)
    }
}
```

---

## API Reference

| Method | Description |
| :--- | :--- |
| `configure(account_id: String)` | Manually sets the Account ID if not present in Info.plist. |
| `detect(image: UIImage, completion: ...)` | Uploads an image to the API for detection. |
| `searchFor(search_url: String?, completion: ...)` | Performs a search using a direct URL. |
| `getSimilarsFor(productId: String?, ...)` | Fetches similar products based on ID. |
| `openUploadPageFor(containerVC: UIViewController)` | Presents the built-in UI for image visual search. |

## License

This project is licensed under the MIT License.
