echo "Downloading Fedora"
if [ ! -f "$DOWNLOAD_DIR/fcrepo-installer-3.8.1.jar" ]; then
  wget -q -O "/tmp/fcrepo-installer-3.8.1.jar" "https://github.com/fcrepo3/fcrepo/releases/download/v3.8.1/fcrepo-installer-3.8.1.jar"
else
  cp "$DOWNLOAD_DIR/fcrepo-installer-3.8.1.jar" "/tmp/fcrepo-installer-3.8.1.jar"
fi

echo "Installing Fedora"
java -jar /tmp/fcrepo-installer-3.8.1.jar "$SHARED_DIR"/configs/install.properties

# Check the exit code from the installation process
if [ $? -ne 0 ]; then
  # Had a corrupt jarfile in cache, if can't install then redownload it
  echo "Problem with jar file, redownloading"
  wget -q -O "/tmp/fcrepo-installer-3.8.1.jar" "https://github.com/fcrepo3/fcrepo/releases/download/v3.8.1/fcrepo-installer-3.8.1.jar"
  java -jar /tmp/fcrepo-installer-3.8.1.jar /tmp/install.properties

  if [ $? -ne 0 ]; then
    echo "Failed a second time to install from the Fedora jar... Can't proceed!"
    exit 1
  else
    # Copy files to the downloads directory if they were successfully used
    cp "/tmp/install.properties" "$DOWNLOAD_DIR/install.properties"
    cp "/tmp/fcrepo-installer-3.8.1.jar" "$DOWNLOAD_DIR/fcrepo-installer-3.8.1.jar"
  fi
fi
