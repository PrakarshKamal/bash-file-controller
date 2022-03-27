
# CS1XA3 Project01 - <*kamalp*>


## Usage

**Execute** the script from project root with:
```
chmod +x CS1XA3/Project01/project_analyze.sh
./CS1XA3/Project01/project_analyze arg1 arg2 ...

```
The user should input **one** of the 7 arguments when the following prompt shows up:

*"Which feature do you want to try: 6.4, 6.5, 6.6, 6.7, 6.8, Custom1 or Custom2 ?"*
  * 4
  * 5
  * 6
  * 7
  * 8
  * Custom1 (1)
  * Custom2 (2)

>If the user inputs any other argument, an error message will pop-up and the file will run once again until an acceptable input is entered.

>The ```IFS``` value is set to ```\n``` to account for **whitespace** in file names or other situations where **whitespace** is an issue.

> The ```$absolute_path``` variable is responsible for accounting the fact that the user may not necessarily have a ```private``` directory created. The script will work wherever and however the user clones the repository.

-----------------------------------------------------------------

### Feature 6.4
  ~~ **Description**: This feature lists all **files** in the repository along with their sizes in a comprehensible readable format such as Bytes, KiloBytes(K), MegaBytes(M), GigaBytes(G). The files get listed in descending order of size. 

The ```du -a -h``` flags look for hidden files and puts them in a readable format. The ```grep -v '^-'``` grabs only **files**. The ```sort -r``` command implements the sorting of the files (largest to smallest)

  ~~ **Execution**: Execution of this feature occurs when the user inputs **4** as the argument.
   * The script outputs the list of **ALL** files in the repository.
   * Files get sorted in descending order of size
   * Size is represented in human readable format
   * An example list output of feature 6.4:

    1.5G       /home/kamalp/private/CS1XA3/a.jpeg
    736M       /home/kamalp/private/CS1XA3/b.py
    8.0K       /home/kamalp/private/CS1XA3/c.sh
    227       /home/kamalp/private/CS1XA3/d.txt

  ~~ **Reference**: [```du``` command](https://www.geeksforgeeks.org/du-command-linux-examples/)

>**Pitfall of this feature**: Upon running feature 6.4, the output list includes some hidden directories and the files in them. The output should not display directories however there is some error in the code script when piping the ```du``` ```grep``` and ```sort``` commands.
-----------------------------------------------------------------

### Feature 6.5
  ~~ **Description**: This feature prompts the user for any **file extension**. After inputting a file extension, the command ```wc -l``` counts the total number of files (with that specific extension) present in the repository. 

The ```find``` command is used to locate **ALL** the files (hidden aswell!) in the repo with the given extension. If zero files are found or the user inputs an incorrect file extension, the script simply outputs *"No such file found!"*

  ~~ **Execution**: Execution of this feature occurs when the user inputs **5** as the argument. 
   * User is prompted for file extension
   * If no file found or incorrect extension entered, output is 
     None
   * Else, the total number of files with the given extension is 
     outputted. 
   * For example **.py** extension is entered. 

     ```The total number of files in repository if 9```

-----------------------------------------------------------------

### Feature 6.6
  ~~ **Description**: This feature prompts the user for any single **word** they would like to search for. The script looks for lines in .py (python files) that begin with a comment ```#```, include the **"word"** on those lines and echoes them into a a file **"Tag.log"** where **"Tag"** is the **"word"** inputted by the user. In the case where the **Tag.log** file is non-existent, the script creates it but overwrites if the log file is present. 

The ```find``` command searches for only **.py** files in the repository. The ```grep -E``` command matches the given **"word"** with the contents of the file(s). The ```grep -w``` only searches for the **"word"** and ignores any following words.

 ~~ **Execution**: Execution of this feature occurs when the user inputs **6** as the argument.
   * User is prompted for a single **"word"**
   * Create a log file **Tag.log** (**Tag** is the **word** 
     inputted) if file is non-existent.
   * Overwrite with ```>``` if file exists.
   * Searches for lines in **.py** files beginning with a comment 
     ```#``` including the **"word"** on the commented lines
   * Echoes the lines in **"Tag.log"**
   * Use ```cat``` to print the contents of the file(s)
   * Example output for Feature 6.6 (**"word"** is **"ABC"**):

      ```
      cat ABC.log

      /home/kamalp/private/CS1XA3/Project01/test1.py:#ABC HELLO WORLD!
      /home/kamalp/private/CS1XA3/Project01/test2.py:#ABC I <3 BASH!!!

--------------------------------------------------------------------

### Feature 6.7

 ~~ **Description**: This feature manipulates file permissions based on existing file permissions. The script looks for `.sh` (shell script) files in the repository using the `find` command. The user is prompted for 2 options by the `read` command, Change or Restore. If they select **'Change'**, the script runs and changes file permissions; gives **executable** `x` permissions to only those who have **writable** `w` permissions. The `chmod` command changes file permissions based on the criteria.

The original permissions get stored in a log file **permissions.log** using the `stat`command.
The `cut` command gets the specific permissions required.

If user selects **'Restore'**, the script runs and restores the file permissions that were originally stored in **permissions.log**

~ **Execution**: Execution of this feature occurs when the user inputs **7** as the argument.
   * User is prompted to **'Change'** or **'Restore'**
   * All shell scripts `.sh` are searched
   * Log file **permissions.log** is created
   * Original permissions of files are appended with `>>` to 
     **permissions.log**
   * If user selects **'Change'**:
   * If group has `w` permissions, then only group has `x` 
     permissions etc.
  

   * If user selects **'Restore'**:
   * The original file permissions are restored which were present 
     in **permissions.log**

   * Example output for Feature 6.7:
     ```
      The original permissions for the file are: 664   -rw-rw-r--   
      /home/kamalp/private/CS1XA3/Project01/g.sh
      The original permissions for the file are: 777   -rwxrwxrwx   
      /home/kamalp/private/CS1XA3/Project01/project_analyze.sh
      The original permissions for the file are: 664   -rw-rw-r--   
      /home/kamalp/private/CS1XA3/Project01/h.sh
      The original permissions for the file are: 664   -rw-rw-r--   
      /home/kamalp/private/CS1XA3/Project01/f.sh
      The original permissions for the file are: 664   -rw-rw-r--   
      /home/kamalp/private/CS1XA3/Project01/e.sh
     ```

~ **Reference**: 
   [`stat` command](https://www.computerhope.com/unix/stat.htm)
   [`cut` command](https://www.geeksforgeeks.org/cut-command-linux-examples/)

--------------------------------------------------------------------

### Feature 6.8
 ~~ **Description**: This feature allows user to manipulate `.tmp` files. The script looks for `.tmp` files in the repository using the `find` command. The user is prompted for 2 inputs by the `read` command, Backup or Restore. 

If they select **'Backup'**, the script runs and creates an empty directory `backup` if it does not exist, else it clears the content if it is existing. Only files that end with `.tmp` get copied to the `backup` directory. A new file `restore.log` is also created in `backup` which contains the original file paths of the `.tmp` files. 

If the user selects **'Restore'**, the script runs and all the `.tmp` files restored back to their original location 
This happens with the `basename` and `dirname` commands.

 ~~ **Execution**: Execution of this feature occurs when the user inputs **8** as the argument.

   * User is prompted to **'Backup'** or **'Restore'**
   * If user selects **'Backup'**:
   * All `.tmp` files are searched
   * They are copied to `backup`
   * Log file `restore.log` is created which contains all original 
     file paths

   * If user selects **'Restore'**:
   * The `.tmp` files in `backup` are restored back to their 
     original location
   
   * Example output for Feature 6.8:
     ```
     Would you like to Backup or Restore?
     Restore
     File name: m.tmp
     Directory name: /home/kamalp/private/CS1XA3/Project01
     File name: n.tmp
     Directory name: /home/kamalp/private/CS1XA3/Project01
     File name: p.tmp
     Directory name: /home/kamalp/private/CS1XA3/Project01
     File name: o.tmp
     Directory name: /home/kamalp/private/CS1XA3/Project01
     File(s) have been restored to original location!

     ```
 ~~ **Reference**: 
[`basename` command](https://www.geeksforgeeks.org/basename-command-in-linux-with-examples/)
[`dirname` command](https://www.geeksforgeeks.org/dirname-command-in-linux-with-examples/)

--------------------------------------------------------------------
### Custom Feature 1 (Owner of Files)

 ~~ **Description**: This feature counts the total number of occurences of a **"word"** (prompted by the user) for files present in the repository and checks if any of the files are owned by the user editing the script. The `find` command searches for files in the repository. The `grep` command searches for the **'word'** prompted by the user and the `wc -l` command counts the number of files that contain the **'word'**.

Whether or not the user owns the file is specified by the file permissions. If the **user** has `read` `r` **and** `write` `w` permissions, then they own the file. The `cut` command checks for the only the user having `r` and `w` permissions.

 ~~ **Execution**: Execution of this feature occurs when the user inputs **1** as the argument.

   * All files in the repository are searched
   * Files containing the **'word'** prompted by user are grepped
   * Number of files with **'word'** are echoed
   * File permissions are checked
   * If only user has `r` and `w` permissions then
   * Script outputs, **File is owned!**
   * Else, **File is NOT owned!**
   * Example output for Custom Feature 1:
     ```
     Number of files with 'XYZ' in repository is:
     /home/kamalp/private/CS1XA3/Project01/c.py
     /home/kamalp/private/CS1XA3/Project01/b.sh
     /home/kamalp/private/CS1XA3/Project01/a.txt
     File is owned!
     File is NOT owned!
     File is owned!
     ```
--------------------------------------------------------------------

### Custom Feature 2 (Search & Modify)
 ~~ **Description**: This feature finds all text files (i.e ending in ```.txt```) in the repository using `find`. For all files that end in `.txt` it gives all permissions to everyone that is, user has `rwx` permissions, group has `rwx` permissions and others have `rwx` permissions which is done using `chmod`.

 ~~ **Execution**: Execution of this feature occurs when the user inputs **2** as the argument.

   * All `.txt` files are searched
   * User is given `rwx` permissions
   * Group is given `rwx` permissions
   * Others are given `rwx` permissions
   * Final file permissions are `-rwxrwxrwx`
   * Example output for Custom Feature 2 is:
     ```
     Files are: /home/kamalp/private/CS1XA3/Project01/g.txt
     /home/kamalp/private/CS1XA3/Project01/h.txt
     /home/kamalp/private/CS1XA3/Project01/e.txt
     /home/kamalp/private/CS1XA3/Project01/f.txt
     You now have ALL file permissions!
     ```    

