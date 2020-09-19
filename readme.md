
# Factorio Headless Server Ansible Playbook
I created this because I wanted some experience with Ansible and the other Factorio based Ansible repositories I found were for  a much more policed role where you could create your own pla>

Mine is much more of a 'quick and dirty' download and setup factorio

Once finished you will have the latest version of a factorio headless linux server located in /opt/factorio and a cronjob that runs the backup.sh every 4 hours. That backup.sh will backup your saves directory to the bak folder. This is because if your base has an issue for more than an hour or so and you don't notice it, all your autosaves could be overwritten if it's left to run.

 Once you run the playbook it will install everything and then start the server in a tmux session. You can access the server console by attaching to this tmux session with "sudo tmux attach" (pressing ctrl+c in this menu will close the server). After the first start of the server you can start the server by running the start_server.sh however you'd like. I choose to open it in a tmux session

## Install
You could copy this playbook to your Ansible server and serve this playbook to any machine you want but anyone who already has an Ansible server will know how to deploy this file that way.
If you are like me then you want a quick way to deploy this standalone on one specific server (yes this defeats the purpose of Ansible, but I wanted the experience) so I will give instructi>

### 1. Install Ansible and add host 
* Install any Linux distro that uses apt-get, probably Ubuntu server
* make sure the user "user" exists and use that for installation (for now, this req will be removed in the future)
* Install Ansible
```
sudo apt-get install ansible
```
* Add a server for Ansible to apply this playbook to. We are using localhost because we are configuring the machine we are currently on. If you want you could specify an ip to configure a different server. We configure this by editing the **/etc/ansible/hosts** file and adding our ip/hostname

Add this text to the bottom of the file and fill in a user/pass that can ssh into your machine (probably the ones you are already logged in with). Note that the playbook applies itself to the 'gameserver' group so be sure you have your group named 'gameserver' (or edit the playbook). (For now the user has to be 'user' until I remove some hard-coded usernames)
```
[gameserver]
localhost

[gameserver:vars]
ansible_user=<user>
ansible_password=<pass>
```

### 2. Download playbook, setup server, and launch
* Next we can clone this repository, change a few server settings and run the playbook. First download the repository, and cd into the directory 
```

user@ubuntu20:~/test$ git clone https://github.com/tylerwight/Factorio_Ansible_Playbook
user@ubuntu20:~/test$ ls
Factorio_Ansible_Playbook
user@ubuntu20:~/test$ cd Factorio_Ansible_Playbook/
user@ubuntu20:~/test/Factorio_Ansible_Playbook$ ls
backup.sh  genmap.sh  install_factorio_headless.yml  map-gen-settings.json  server-settings.json  start_server.sh
user@ubuntu20:~/test/Factorio_Ansible_Playbook$

 ```
* Now we need to edit the server config before we run the playbook. The server-settings.json in the directory will be pushed out to the server when we run the playbook. Open server-setting.json and edit it. If you want your server to show up online be sure to add a factorio username/password. You may also want to edit the name and password. 
```
nano server-setting.json
```
*Finally, run the playbook. This will download the latest version of factorio server, install it to /opt/factorio and also copy of some easy to use scripts to run it. Note that when you first run the playbook it automatically starts the server. You can see if it's started by using the command 'ps auxf' and look for factorio. Run this command to start once your server-settings.json is edited:
```
 ansible-playbook ansible_test.yml -kK
 ```
Note: the -kK in this command makes it first ask for the password for the base user, and then ask for a second password that is the sudo password because we are using sudo


## todo:
1. have it create a factorio user and use that, rather than assuming the 'user' user exists and using that

