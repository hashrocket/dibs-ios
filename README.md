# Intention

Dibs iOS is intended to serve as an example of clean OO design in Objective-C
using the iOS framework. It uses modern layout approaches
([NSLayoutConstraints][nslc]) and utilizes programatic view generation. Dibs
iOS also serves as a good example of integrating with Facebook for
authentication and content delivery utilizing the [Facebook SDK][fsdk] for
iOS. Additionally, Dibs iOS utilizes the [Pixate][pix] framework to decouple
presentation and behavior where possible.


# Requirements

Dibs iOS depends on [cocoapods][pods], [Ruby][ruby] and [RubyGems][gems]. It
will make use of [RVM][rvm] or [rbenv][rbenv] if present.  Your system is
assumed to have [RubyGems][gems] installed and working for the purposes of the
installation directions. Information on installing these libraries can be
found at the provided links.

Views in this application take advantage of the [Pixate][pix] framework (which
is now free to use commercially) and you must have a valid license in order to
build the application.

Dibs iOS authenticates through and serves content to facebook and requires you
to provide a Facebook App ID in order to build the application.

# Setup

1. `gem install cocoapods`
1. `pod install`

# Configuration

1. `cp Support/Environments.plist{.example,}`
1. Edit `Support/Environments.plist` to add values for:
    * your Facebook App ID
    * Pixate license information
    * Environments you wish to build against (no configuration is necessary to
      use the Dibs production endpoint)

# Build and Run

1. `open Dibs.xcworkspace`
1. In Xcode, select the "Production" scheme and the device to build to (note
   that in order to deploy outside the simulator, you will need a valid Apple
   Developer License).
1. Click the "Run" button

# Contributing

Please add feature requests and bug reports to our [issue tracker][trkr] on
github.

# Licensing

Dibs iOS is released under the terms of the [Eclipse Public License, Version
1.0][epl1]. See the LICENSE document for full details.


[nslc]:
http://developer.apple.com/library/mac/#documentation/AppKit/Reference/NSLayoutConstraint_Class/NSLayoutConstraint/NSLayoutConstraint.html
[fsdk]: https://developers.facebook.com/ios/
[pods]: http://cocoapods.org/
[ruby]: http://www.ruby-lang.org/
[gems]: https://rubygems.org/pages/download
[rvm]:  http://rvm.io/
[rbenv]:https://github.com/sstephenson/rbenv
[pix]:  http://www.pixate.com/
[trkr]: https://github.com/hashrocket/dibs-ios/issues
[epl1]: http://www.eclipse.org/legal/epl-v10.html
