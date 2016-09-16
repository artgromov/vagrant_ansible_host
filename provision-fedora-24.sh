#!/bin/bash
echo "=================================================="
echo "Installing system packages"

dnf install -y \
            gcc \
            redhat-rpm-config \
            python \
            python-devel \
            python-crypto \
            libselinux-python \
            libffi-devel \
            openssl-devel \
            sshpass \
            git > /dev/null

echo "Installing python modules"

pip install --upgrade pip > /dev/null
pip install \
            paramiko \
            PyYAML \
            Jinja2 \
            httplib2 \
            six  > /dev/null

echo "Cloning and installing ansible from source"

cd /opt
git clone git://github.com/ansible/ansible.git --recursive > /dev/null
cd ansible
source ./hacking/env-setup -q > /dev/null
chown -R vagrant:vagrant /opt/ansible

echo "Customizing environment"

echo "source /opt/ansible/hacking/env-setup -q" >> /home/vagrant/.bash_profile
echo "cd /vagrant" >> /home/vagrant/.bash_profile

echo "Creating updater script"

cat >> /usr/bin/ansible-update << EOF
#!/bin/bash

git -C /opt/ansible pull --rebase
git -C /opt/ansible submodule update --init --recursive

EOF

chmod a+x /usr/bin/ansible-update

echo "=================================================="
