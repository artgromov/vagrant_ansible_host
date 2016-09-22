#!/bin/bash
echo "Installing dependencies"

dnf install -y gcc \
               redhat-rpm-config \
               libselinux-python \
               libffi-devel \
               openssl-devel \
               sshpass \
               git \
               python \
               python-devel \
               python-crypto \
               python2-paramiko \
               python-jinja2 \
               python-httplib2 \
               python-six

pip2 install PyYAML > /dev/null


echo "Installing ansible in /opt/ansible to run from source"

git clone git://github.com/ansible/ansible.git --recursive /opt/ansible
source /opt/ansible/hacking/env-setup -q


echo "Customizing environment"

cat > /etc/profile.d/ansible.sh << EOF
export PATH=$PATH:/opt/ansible/bin
export PYTHONPATH=$PYTHONPATH:/opt/ansible/lib
EOF


echo "Creating updater script /usr/bin/ansible-update"

cat > /usr/bin/ansible-update << EOF
#!/bin/bash

/bin/git -C /opt/ansible pull --rebase
/bin/git -C /opt/ansible submodule update --init --recursive

EOF

chmod 744 /usr/bin/ansible-update
