docker ps -aq | xargs docker stop | xargs docker rm
sudo ip link delete s4-s3-int 
sudo ip link delete s4-s3 
sudo ip link delete s4-s2 
sudo ip link delete s3-s4-int 
sudo ip link delete s3-s4 
sudo ip link delete s3-s1 
sudo ip link delete s2-s4 
sudo ip link delete s2-h2 
sudo ip link delete s1-s3 
sudo ip link delete s1-s2 
sudo ip link delete s1-h1 
sudo ip link delete s2-s1 
sudo ip link delete s4-s3
sudo ip link delete s2-s3 
sudo ip link delete s4-s3 
