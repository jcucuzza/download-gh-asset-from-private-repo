# Download GitHub assets from private repository

Having difficulty downloading an asset associated with a release from a private repository programmatically? No worries! You are in good hands!

To download the script, run the following command:

```
curl -L -o download-by-tag.sh https://raw.github.com/jcucuzza/download-gh-asset-from-private-repo/main/download-by-tag.sh
```

If the script is not executable once it has been downloaded, you may have to change its permissions.

```
chmod -R 777 ./download-by-tag.sh
```

Pass the required arguments to the script and run it

```
./download.sh <github-pat-token> <owner> <repository> <tag> <asset>
```
