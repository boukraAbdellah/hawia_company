to build the next version of the app
so it's eligible for updates in google play
all the three apps already use the same keystore
(found in my-release-key.jks)
these files are sensitive so don't share them
and you will need them to generate next build version
/android/app/build.gradle.ts is already updated to read the key properties
#####
the two files are :
my-release-key.jks
key.properties
put those files on /android (of all the three apps)
######

