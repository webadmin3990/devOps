Task1. Part 1
1) Log in to the system as root

![img.png](img/login.png)

2) Use the passwd command to change the password. Examine the basic parameters of the command. What system file does it change

![img.png](img/changePass.png)

File:
>/etc/passwd

>/etc/shadow

3) Determine the users registered in the system, as well as what commands they execute. What additional information can be gleaned from the command execution

![img.png](img/usersSystem.png)

4) Change personal information about yourself.

>andrea@ubuntu:/home/guru$ sudo chfn guru


![img.png](img/changeFullName.png)

5) Become familiar with the Linux help system and the man and info commands.
   Get help on the previously discussed commands, define and describe any two keys for these commands.
   Give examples
   
>guru@ubuntu:~/$ man chfn
>
>guru@ubuntu:~/$ info chfn
   
6) Explore the more and less commands using the help system.
   View the contents of files .bash* using commands.
   
![img.png](img/manMore.png)

![img.png](img/manLess.png)

![img.png](img/moreBash.gif)

![img.png](img/lessBash.gif)
   
7) * Describe in plans that you are working on laboratory work 1.
    Tip: You should read the documentation for the finger command.
     
>guru@ubuntu:~$ finger
>
> guru@ubuntu:~$ finger -l

     
![img.png](img/finger.gif)
     
8) * List the contents of the home directory using the ls command, define its files and directories.
    Hint: Use the help system to familiarize yourself with the ls command.
     
>guru@ubuntu:~$ ls -l

![img.png](img/ls.png)

