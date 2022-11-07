```bash
1991  ssh-keygen -t rsa -b 4096
 1992  cat id_rsa.pub >> authorized_keys
 1995  ssh-keyscan -H 10.1.3.102 >> ~/.ssh/known_hosts
 1996  ssh-keyscan -H 10.1.3.103 >> ~/.ssh/known_hosts
 1997  ssh-keyscan -H 10.1.3.104 >> ~/.ssh/known_hosts
```
