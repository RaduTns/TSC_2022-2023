::========================================================================================
call clean.bat
::========================================================================================
call build.bat
::========================================================================================
cd ../sim
vsim -%5 -do "do run.do %1 %2 %3 %4"
