HelloCI is a Continuous Integration Environment Configuration project based on blogs:

http://visualstudiomagazine.com/articles/2011/07/28/wcoss_coded-builds.aspx
http://zen-and-art-of-programming.blogspot.com/2013/07/how-to-configure-teamcity-and-svn-to.html
https://www.simple-talk.com/dotnet/.net-tools/towards-the-perfect-build/
http://www.pseale.com/blog/StealIdeasFromThesePsakeScripts.aspx

I've updated it to use Nuget Management package and psake instead of MSBuild.

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

- Unit Test

$ .\thirdparty\packages\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1 UnitTest

See also:
https://www.simple-talk.com/dotnet/.net-tools/towards-the-perfect-build/