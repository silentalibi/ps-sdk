READ ME

PSConnection is a complete networking package that can be dropped into applications that want to communicate with Adobe� Photoshop� CS5.1. It includes a Bonjour network browser so that you can discover available Photoshop� Remote Connections, a complete UI that can be added to an application, localized help explaining how to enable Remote Connections and much more.

LICENSE

<TO DO>

HOW TO USE

You can add PSConnection to your project very easily. Since it is a collection of source files and not a framework, you will be compiling the files with your source code. To add the files to your Xcode project:

1)  Open your project in Xcode.
2)  Right-click on the root of your project in the left-hand project tree.
3)  Select Add > Existing Files.
4)  Browse to the extracted PSConnection folder.
5)  With the PSConnection folder selected, click 'Add'.
6)  When prompted, make sure that the following option is selected:

'Recursively create groups for any added folders'

7)  Click 'Add'.

A yellow group folder will be created in your project tree containing the source code and resources.

IMPORTANT!

At this point, all the necessary source has been added. However, the localized help requires additional steps. If you build and distribute your application without going through the LOCALIZED HELP steps below, the PSConnection UI will not be able to display help.

Additionally, to get a working build, some of the source requires an iOS framework. Please refer to REQUIRED FRAMEWORKS below to see which one you need and how to add to your project.

SUPPORT FILES

PSConnection relies on several other pieces of code to function.  You can find these other sources in the 'PSConnection' group folder created when you added the sources in the previous step. If these were not added, you can manually add them later using the same method. Check that the PSConnection folder on disk contains the following subfolders:

PSConnection/networking
PSConnection/scripts
PSConnection/sfhfkeychainutils
PSConnection/synthesizesingelton
PSConnection/uicolorexpanded

REQUIRED FRAMEWORKS

The shfhkeychainutils source requires the Security.framework that is provided with iOS. You will not be able to successfully build PSConnection into your project without this. To add the framework, do the following:

1)  Open your project in Xcode.
2)  Right-click the yellow Frameworks group folder in the left group tree.
3)  Select Add > Existing Frameworks.
4)  Scroll and select Security.framework
5)  Click 'Add'.

The yellow framework package will be added to the Frameworks group folder. You should now be able to build PSConnection as part of your project.

LOCALIZED HELP

PSConnection includes help localized for English, German, French and Japanese. To properly access localized help in your application, the help files need to be added to your project in a slightly different manner than the other files. If you followed the previous steps to add PSConnection to your project, then the help has been added in the wrong way. To add the localized help files, do the following:

1)  Open your project in Xcode.
2)  Add PSConnection to your project if you haven't already.
3)  Expand the yellow 'PSConnection' group folder in the left-hand group tree.
4)  Right-click on the yellow 'help' subfolder.
5)  Select 'Delete'. When prompted, click 'Delete References'.
6)  Right-click on the yellow 'PSConnection' subfolder.
7)  Select Add > Existing Files.
8)  Browse to the 'PSConnection' folder on disk.
9)  Select 'help' and click 'Add'.
10) When prompted, make sure the following option is selected:

'Create folder references for any added folders'

11) A blue 'help' folder will be created and added to the yellow 'PSConnection' group folder.

IMPORTANT!

The significance of the yellow vs. blue group folder is crucial. The blue folder will retain its structure when copied to your application's package. Without this, the localized versions of the help files cannot be distinguished and your app will end up using the last copied help files.

IF THE HELP FOLDER IS NOT BLUE, THE HELP WILL NOT BE COPIED TO YOUR APPLICATION PACKAGE CORRECTLY.

KNOWN ISSUES

****** RECEIVING RAW PIXMAPS FROM PS ******
Sending raw and JPG images to PS is supported. However, receiving raw pixmaps from PS is not yet supported. This is because the conversion from RGB to RGBA using CoreGraphics contexts is somewhat awkward, and doesn't seem to work consistently. Consider using high-quality JPGs until this is fixed in a later version of the SDK.

****** SUBSCRIBING TO MULTIPLE PS EVENTS ******
PSConnection only allows you to subscribe one target to one type of event in PS. For example, you cannot have two targets subscribe to the same event using [PSConnection subscribeToEvent:target:selector]. Multiple subscriptions to the same event will simply replace the previous subscription.