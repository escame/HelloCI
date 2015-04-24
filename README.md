HelloCI is a Continuous Integration Environment Configuration project based in this blog:

http://zen-and-art-of-programming.blogspot.com/2013/07/how-to-configure-teamcity-and-svn-to.html

I've updated to use Nuget Management package and psake instead of MSBuild.

Usage:
In a Powershell command Line execute from the HelloCI folder:

.\thirdparty\libs\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1

You can add different target than the default.

i.e.
.\thirdparty\libs\psake.4.4.1\tools\psake.cmd .\HelloCI.build.ps1 Compile

See also:
https://www.simple-talk.com/dotnet/.net-tools/towards-the-perfect-build/