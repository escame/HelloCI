HelloCI is a Continuous Integration Environment Configuration project based in this blog:

http://zen-and-art-of-programming.blogspot.com/2013/07/how-to-configure-teamcity-and-svn-to.html

I've updated to use Nuget Management package and psake instead of MSBuild.

Usage:
In a shell command Line window, execute from the HelloCI folder:

$ .\thirdparty\packages\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1

You can add different targets other than the default (check HelloCI.build.ps1 script)

- Compile Project

$ .\thirdparty\packages\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1 Compile

- Start Website (connect http://localhost:9999/)

$.\thirdparty\packages\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1 StartWebsite

- Stop Website

$ .\thirdparty\packages\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1 StopWebsite

See also:
https://www.simple-talk.com/dotnet/.net-tools/towards-the-perfect-build/