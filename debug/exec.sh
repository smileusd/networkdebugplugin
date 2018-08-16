#!bin/bash

debugdir=/tmp/networktool
debugpoddir=/opt/kubernetes/debug
debugimage=busybox
container=""
pod=$KUBECTL_PLUGINS_LOCAL_FLAG_POD
id=""

# copy busybox to host
id=$(docker run -d --privileged -v $debugdir:$debugdir $debugimage sh -c "mv /bin/busybox $debugdir")
if [ "$id" = "" ]; then exit 0; fi

# parse plugin args
if [ $# -ne 0 ] && [ "$pod" = "" ]; then 
	pod=$1
	shift
fi
if [ "$KUBECTL_PLUGINS_LOCAL_FLAG_CONTAINER" ]; then
	container="-c $KUBECTL_PLUGINS_LOCAL_FLAG_CONTAINER"
fi
args=$*

# copy busybox from host to container
$KUBECTL_PLUGINS_CALLER exec  $pod $container -n $KUBECTL_PLUGINS_CURRENT_NAMESPACE -- sh -c "mkdir -p $debugpoddir"
$KUBECTL_PLUGINS_CALLER cp $debugdir/ $KUBECTL_PLUGINS_CURRENT_NAMESPACE/$pod:$debugpoddir $container
echo "copy busybox to $debugpoddir"

# exec container
$KUBECTL_PLUGINS_CALLER exec -it $pod $container -n $KUBECTL_PLUGINS_CURRENT_NAMESPACE -- $args

# clean containers
docker rm $id > /dev/null

exit 0
