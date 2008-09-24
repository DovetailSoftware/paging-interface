Gary Sherman; 8/22/2008

I had to compile pager_clerk.exe today, and here's how I did it.

I used the machine Bedlam, which is Steven Weintraub's old, old NT4 machine.
Bedlam has Visual Studio 97; VC++ 5.0 installed.
Logged in as stevenw, but I dont think this matters.
The paging source and build/make files are in e:\fchoice\paging\pager
Open a dos command prompt.
cd to e:\fchoice\paging\pager
run build.bat
this sets up the needed environment variables, and runs nmake.
It should create a new pager_clerk.exe in the Release directory.


Gary Sherman; 8/23/08
I've modified the pager_clerk app so that it uses GUIDs as part of the file name on Windows.
We could do this on UNIX as well, I just don't know how (I don't even know how to build this on UNIX).
