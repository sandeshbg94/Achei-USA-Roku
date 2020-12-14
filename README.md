# Achei-USA-Roku
This is a Roku Channel that lists videos in the Roku Rowlist. On selecting any item in the list the details of the video will be visible to the User, with an option to play the selected video. This Roku Channel also demonstrates Deeplink integration in Roku.

# Steps to Side Load the Channel
1. Enable Developer Settings in the Roku Device as mentioned in https://developer.roku.com/en-gb/docs/developer-program/getting-started/developer-setup.md
2. Access the Application installer from the web browser by entering the Roku device's URL (i.e. http://192.168.x.x)
3. Create a zip archive of this repository or alternatively you can use the zip archive present in this repository
4. Upload the archive in the installer opened in web browser as mentioned in step 2 and press install. This will side load the channel and start the channel in the device

# Testing Deep Link Integration
This channel also has Deep Linking. To test the Deep Link use - http://devtools.web.roku.com/DeepLinkingTester/ . Use Channel Name **Achei USA** for Deep Linking. The content id for testing Deep Link can be found in https://hosttec.online/rokuxml/achei/achei.json
