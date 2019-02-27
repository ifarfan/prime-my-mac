# prime-my-mac
Automate local, new mac setup and configuration

# Installation:
**To bootstrap, on first install:**
```bash
curl -fsSL https://raw.githubusercontent.com/ifarfan/prime-my-mac/master/bootstrap.sh | bash
```

# Pre-requisites:
N.O.N.E.  A.T.   A.L.L.

This is intended to run on a brand new, pristine, virgin Mac.

# What's going on here?!?
The automated installation pretty much boils down to:

- Install XCode cmdline tools
- Install package managers: `pip` + `brew`
- Install `pip` packages
- Install `brew` and `brew cask` packages, with some `fonts` thrown in for good measure
- Setting personalized tweaks to some MacOS + GUI apps
- Copying over my own `.` (dot) + other miscellaneous files
- Running obscure `default.write.*` commands that control the MacOS look and feel
- And a fair amount of convoluted `Bash` to glue it all together


Some things to note:

- The actual list of apps + utilities to install are under `libs\data.sh`
- Mac tweaks are all under `libs\osx.sh`
- Specific app tweaks are under `libs\apps.sh`
- My shell of choice is `prezto` (*zsh*), thus my `.` files reflect that
- I still install `bashit` for the few times I need to jump back to a `bash` prompt
- I used to be big on `Sublime Text` but like all the cool kids switched to `VSCode` and couldn't be happier; specially since it's such a breeze to automate its installation


# Oh god, why?!?
When I first switched to the Mac *weltanschauung*, I learned pretty fast the utter folly and sado-masochistic tendencies of those who try to simply **upgrade** their OS by running the installer of whatever new MacOS version Apple releases (which come out on a yearly basis) on top of their existing installation. 

I do Devops and *immutable infrastructure* is basically a religious tenant, so "duh!" I should do the same with my own workstation. Sadly not everything can be *reliably* automated (I'm looking at you both AV + MS-Office) but this is the closest I've come to that promised land. 

The above being said, that *new leather* smell of a newly reformatted disk + fresh OS install on my trusty old Macs, after I run this script, is the greatest feeling. Every now and then `brew` will act up and not install everything it's told so, no worries, just run the script again.

One day when I finally switch to a full-on Linux workstation I'll then be able to simply use *Ansible* to fully provision my box anew each time I need and/or  when it gets replaced. In the interim, this will do for now...