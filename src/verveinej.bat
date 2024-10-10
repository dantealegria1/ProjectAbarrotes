@echo off
setlocal ENABLEDELAYEDEXPANSION

rem Directory for verveine source
set ROOT=%~dp0%
set BASELIB=%ROOT%lib

rem JVM options e.g. -Xmx2500m to augment maximum memory size of the vm to 2.5Go.
rem set JOPT="-Xmx2500m"
rem Verveine option
rem set VOPT="."

FOR /R %BASELIB% %%G IN (*.jar) DO set LOCALCLASSPATH=%%G;!LOCALCLASSPATH!
set CLASSPATH=%CLASSPATH%;%LOCALCLASSPATH%

java %JOPT% fr.inria.verveine.extractor.java.VerveineJParser %1 %2 %3 %4 %5 %6 %7 %8 %9
