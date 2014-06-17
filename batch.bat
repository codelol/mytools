PEM This script is for Windows shell. It executes a bunch of .icf files one by one.
@ECHO OFF
for /f "tokens=*" %%a in ('dir /b *.icf') do (
    for /l %%x in (1, 1, 100) do (
	    echo %%a-%%x
	    "C:\Program Files (x86)\Iometer.org\Iometer 2006.07.27\Iometer.exe" /c %%a /r %%a-%%x.csv
	)
)
