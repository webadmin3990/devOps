Task assignment.
1) Analyze the structure of the /etc/passwd and /etc/group file,
   what fields are present in it, what users exist on the system?
   Specify several pseudo-users, how to define them?
   
>guru@ubuntu:~$ cat /etc/passwd

![img.png](img/passwd_group.png)

>guru@ubuntu:~$ cat /etc/group

![img.png](img/group.png)

2) What are the uid ranges? What is UID? How to define it?
   
![img.png](img/user_id.png)

3) What is GID? How to define it?

![img.png](img/group_id.png)

4) How to determine belonging of user to the specific group?
   
![img.png](img/belong_group_id.png)

5) What are the commands for adding a user to the system?
   What are the basic parameters required to create a user?
   
>guru@ubuntu:~$ sudo useradd test1
> 
>guru@ubuntu:~$ sudo passwd test1
>
>guru@ubuntu:~$ sudo adduser test2

![img.png](img/addUser.png)

6) How do I change the name (account name) of an existing user?

![img.png](img/chage_user_name.png)

7) What is skell_dir?

![img.png](img/skel.png) 

What is its structure?

![img.png](img/skel_change.png)
   
8) How to remove a user from the system (including his mailbox)?
   
![img.png](img/user_del_without_mail.png)

9) What commands and keys should be used to lock and unlock a user account?
   
![img.png](img/user_lock_unlock.png)

10) How to remove a user's password and provide him 
    with a password-free login for subsequent password change?
11) Display the extended format of information about the directory,
    tell about the information columns displayed on the terminal.
12) What access rights exist and for whom (i. e., describe the main roles)?
    Briefly describe the acronym for access rights.
13) What is the sequence of defining the relationship between the file and the user?
14) What commands are used to change the owner of a file (directory),
    as well as the mode of access to the file? Give examples, demonstrate on the terminal.
15) What is an example of octal representation of access rights? Describe the umask command.
16) Give definitions of sticky bits and mechanism of identifier substitution.
    Give an example of files and directories with these attributes.
17) What file attributes should be present in the command script?