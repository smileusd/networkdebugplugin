
A network plugin to debug a problem pod in kubernetes.


#### INSTALL:
git clone the project
```
mkdir -p ~/.kube/plugins/
cp -r <project>/debug ~/.kube/plugins/
sudo chmod a+x ~/.kube/plugins/debug/exec.sh
```

#### USAGE:
Use `kubectl plugin debug pod1 -c container1 -n namespace1 sh` to get the shell of container and not need to key "-it".

Then you can use `/opt/kubernetes/debug/busybox` to debug the problem like `./opt/kubernetes/debug/busybox nslookup`.


