::title::       Android Development without Eclipse
::published::   2010-07-27
::tags::        android, programming, java, cli

I started having a bash at some Android programming recently, nothing amazing, just flexing the old Java muscles again (for the first time since university, back when you had to avoid the Velociraptors to get to lectures), and it's actually pretty fun.

What's not fun however is the behemoth that is Eclipse. I swear, before I got fed up and threw it away, I spent longer bashing my head at Eclipse than I actually spent setting up the toolchain, writing some code and getting it on my phone.

Whilst the "Android developer website is amazingly helpful":http://developer.android.com I thought it might help to have a quick reference to get started. And the most important step is to "download the sdk from here":http://developer.android.com/sdk/index.html, unzip this to a directory where it isn't going to get in your way, I use @~/code/android-sdk@ and add @~/code/android-sdk/tools@ to your path.

The next important thing is to install the SDK components for whatever android version you're using and create an Android Virtual Device to use in the emulator. This is all covered in "the Android install guides":http://developer.android.com/sdk/adding-components.html and when your done you should be good to go at creating a project.

The basic workflow is this:

* get the android target version <pre class="brush: bash">android list target</pre> this will return a list of stuff depending on how many platform components you have installed, what's interesting is the line that starts with "id: " because that gives you the @-t@ paramater for use in the next step
* Create your project <pre class="brush: bash">android create project -t 1 -p <path-name-here> -k <package-name> -a <ActivityName></pre>
* Write some codes! then build it with <pre class="brush: bash">ant debug</pre> this will create your .apk that we'll install to the phone
* to get the code on the device we first need to start a device, run the android tool and fire up the avd that you created during the install step, this will start the emulator. Once the emulator has started (this takes about 2-3 minutes on my MacBook) you should be able to do this<pre class="brush: bash">~ > adb devices
List of devices attached
emulator-5554  device</pre> This means the Android bridge is successfully talking to your emulator.
* The last step is to actually push your package to the emulator, this is acheived by <pre class="brush: bash">adb install /path/to/bin/package.apk</pre> And you should be able to use your app on the emulator, Yay.

Note: If you are reinstalling a new version of your app you'll need to add the @-r@ flag to @android install@ otherwise it will whinge that the app apready exists.

The steps to getting your app on an actual phone are pretty much the same however:

* Make sure you have USB debugging turned on on your device and plug in the phone (duh!)
* Run @adb usb@ to restart the bridge listening on the USB interface.
* Verify your device is showing up with @adb devices@ and install as above

and breath a breath of fresh air at being able to use $EDITOR to make cool things again.