# Tips and tricks
## GIT 
### Delete remote branch
```
$ git push --delete <remote_name> <branch_name>
$ git branch -d <branch_name>
```

### Get file history
```
git log -1 -- [file path] (file path must be absolute. its possible to use * wildcard)
```

### Merge only particular directory
https://stackoverflow.com/questions/1214906/how-do-i-merge-a-sub-directory-in-git

```
$ git merge -s ours --no-commit <remote>/<branch> 
$ git read-tree --prefix=<slozka u me>/ -u [<remote>/]<branch>:<slozka na cizim>
$ git rm -r <slozka u me> # slouzi k odmazani lokalni slozky, aby nebyly konflikty. Nutno pouzit pouze při chybě
$ git commit -m '<zprava>'
```

### Delete all local branches
```
git for-each-ref --format '%(refname:short)' refs/heads | grep -v $(git rev-parse --abbrev-ref HEAD) | xargs git branch -D
```

### Get tag commit hash
```
git rev-list -1 <TAG>
```


## Spring
### SQL logging including params
```
logging.level.org.hibernate.SQL=DEBUG
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE
```

## Java SSL
### Disable HTTPS Certificate checks
```
TrustManager[] trustAllCerts = new TrustManager[] {
    new X509TrustManager() {
        public java.security.cert.X509Certificate[] getAcceptedIssuers() {
            return new X509Certificate[0];
        }
        public void checkClientTrusted(
            java.security.cert.X509Certificate[] certs, String authType) {
        }
        public void checkServerTrusted(
            java.security.cert.X509Certificate[] certs, String authType) {
        }
    }
};

SSLContext sc = SSLContext.getInstance("SSL");
sc.init(null, trustAllCerts, new java.security.SecureRandom());
con.setSSLSocketFactory(sc.getSocketFactory());
```

### Java HTTP logging
```
sun.util.logging.PlatformLogger .getLogger("sun.net.www.protocol.http.HttpURLConnection") .setLevel(PlatformLogger.Level.ALL);
```
```
logging.level.org.apache.http=TRACE
logging.level.org.apache.http.wire=DEBUG
```
